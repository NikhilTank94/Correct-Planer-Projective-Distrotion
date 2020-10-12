# -*- coding: utf-8 -*-
"""
Created on Sun Sep 22 11:56:18 2019

@author: Nikhil Tank
"""
import numpy as np
import cv2

img = cv2.imread('cise.jpeg')
NumberOfPoints = 4

m,n,o=img.shape
pt = np.array(((12,178,802,804),(282,992,1118,172)))  # P (x1,x2,x3,x4),(y1,y2,y3,y4)
proj_pt = np.array(((220,217,590,590),(318,802,804,320))) # P' (x1’,x2’,x3’,x4’),(y1’,y2’,y3’,y4’) un-projected image pts.

corr= np.zeros(img.shape)

A = np.array((
(pt[0][0], pt[1][0], 1, 0, 0, 0, -pt[0][0]*proj_pt[0][0], -pt[1][0]*proj_pt[0][0], - proj_pt[0][0]),
(0, 0, 0, pt[0][0], pt[1][0], 1, - proj_pt[1][0]*pt[0][0], - proj_pt[1][0]*pt[1][0], - proj_pt[1][0]),
(pt[0][1], pt[1][1], 1, 0, 0, 0, -pt[0][1]*proj_pt[0][1], -pt[1][1]*proj_pt[0][1], - proj_pt[0][1]),
(0, 0, 0, pt[0][1], pt[1][1], 1, - proj_pt[1][1]*pt[0][1], - proj_pt[1][1]*pt[1][1], - proj_pt[1][1]),
(pt[0][2], pt[1][2], 1, 0, 0, 0, -pt[0][2]*proj_pt[0][2], -pt[1][2]*proj_pt[0][2], - proj_pt[0][2]),
(0, 0, 0, pt[0][2], pt[1][2], 1, - proj_pt[1][2]*pt[0][2], - proj_pt[1][2]*pt[1][2], - proj_pt[1][2]),
(pt[0][3], pt[1][3], 1, 0, 0, 0, -pt[0][3]*proj_pt[0][3], -pt[1][3]*proj_pt[0][3], - proj_pt[0][3]),
(0, 0, 0, pt[0][3], pt[1][3], 1, - proj_pt[1][3]*pt[0][3], - proj_pt[1][3]*pt[1][3], - proj_pt[1][3])))
#A 8X9 matrix

u, s, vh = np.linalg.svd(A, full_matrices=True) # A=u*s*vh

h = np.array(((vh[8][0],vh[8][1],vh[8][2]),(vh[8][3],vh[8][4],vh[8][5]),(vh[8][6],vh[8][7],vh[8][8]))) #last row of vh is h
hinv=np.linalg.inv(h)

# getting the corrected image


for y in range (0,corr.shape[1]-1): 
    for x in range (0,corr.shape[0]-1):
        X = np.array((x,y,1)) #where x,y are pt in unprojected image
        #print(X)
        B = np.matmul(hinv,X) 
        B = B/B[2] #for converting into homogeneous coordinate system
        x_p = int(B[0]) #coord in P
        y_p = int(B[1]) #coord in P
        #print([x_p,y_p,1])
        if x_p>=0 and y_p>=0 and y_p<= img.shape[1]-1 and x_p<= img.shape[0]-1 : # to limit the mapping into matrix
            #corr.item(x,y,z) = img.item(x_p,y_p,z) # unprojected pt image
            corr[x,y,:] = img[x_p,y_p,:]

cv2.imwrite('corr_yes.jpeg',corr)