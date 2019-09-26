import numpy as np
from numba import autojit
import matplotlib.pyplot as plt

@autojit
def mandelbrot_set(real_num,image_num,max_iter):
    z = 0.0j
    c = complex(real_num,image_num)
    
    for i in range(max_iter):
        z = z*z + c
        if abs(z) > 2 :
            return i
        
    return 0


if __name__ == '__main__':
    
    yn = 2000
    xn = 2000
    result = np.zeros([xn,yn])
    
    for xn_index,real_num in enumerate(np.linspace(-2,1,num=xn)):
        for yn_index, image_num in enumerate(np.linspace(-1,1,num=yn)):
            result[xn_index,yn_index] = mandelbrot_set(real_num,image_num,20)
    
    plt.figure(dpi=100)
    plt.imshow(np.flipud(result.T),cmap='hot',interpolation='bilinear',extent=[-2,1,-1,1])
    plt.show() 
    fig = plt.gcf()
    my_dpi = fig.get_dpi()
    fig.set_size_inches(7840.0/float(my_dpi),7840.0/float(my_dpi))
    plt.savefig('mandelbrot_set.jpg')