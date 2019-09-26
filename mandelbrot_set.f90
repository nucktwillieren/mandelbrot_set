integer function mandelbrot_set(real_num,image_num,max_iter)

    implicit none
        complex z,c
        integer i,j,k
        integer,intent(in) :: max_iter
        real,intent(in) :: real_num,image_num

        z = (0,0)
        c = cmplx(real_num,image_num)
        
        do i = 1,max_iter 
            z = z*z + c
            if (abs(z) > 2) then
                mandelbrot_set = i
                return
            endif
        enddo
        
        mandelbrot_set = 0
        return
        
end function mandelbrot_set

implicit none

    integer i,j,k
    integer max_iter,xn,yn,max
    integer,dimension (2000,2000) :: result
    integer,external :: mandelbrot_set
    real,dimension (2000) :: real_num_array,image_num_array
    real max_x,max_y,min_x,min_y
    real vl,vr,vb,vt,xl,xr,yb,yt
    real r_color_intensity,g_color_intensity,b_color_intensity
    
    result(1:2000,1:2000) = 0
    max_x = 1
    min_x = -2
    max_y = 1
    min_y = -1
    xn = 2000
    yn = 2000
    max_iter = 20
    vl = 0.10
    vr = 0.85
    vb = 0.25
    vt = 0.75
    xl = min_x    
    xr = max_x
    yb = min_y         
    yt = max_y

    call opngks
    call set(vl,vr,vb,vt,xl,xr,yb,yt,1)
    call perim(1,0,1,0)
    call gscr(1,10,0.0,0.0,0.0) !black

    do i = 1,xn
        real_num_array(i) =  min_x + (max_x-min_x)*(i-1)/xn
    enddo

    do j = 1,yn 
        image_num_array(j) =  min_y + (max_y-min_y)*(j-1)/yn
    enddo
        

    do j = 1,yn
        do i = 1,xn
            result(i,j) = mandelbrot_set(real_num_array(i),image_num_array(j),max_iter)
        enddo
    enddo
    
    max = 0

    do j = 1,yn
        do i = 1,xn
            if (result(i,j) > max) then
                max = result(i,j)
            endif
        enddo
    enddo

    r_color_intensity = max/max_iter
    g_color_intensity = r_color_intensity/2
    b_color_intensity = r_color_intensity/4
    
    call gscr(1,11,r_color_intensity,g_color_intensity,b_color_intensity)

    do j = 1,yn
        do i = 1,xn
            if (result(i,j) == 0) then
                call gsplci(10)
                call gstxci(10)
            else
                call gsplci(11)
                call gstxci(11)
            endif
            call plchhq(real_num_array(i),image_num_array(j),'+',0.02,0.,0.) 
        enddo
    enddo
    
    call frame

    call clsgks

end