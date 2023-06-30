# lua-image
Support image file I/O and basic manipulation

# PNG

BNF:

    png = header ihdr [plte? idat+ | chunk]* iend
    header = 89 50 4E 47 0D 0A 1A 0A
    ihdr = length IHDR data crc
    iend = length IEND data crc
    plte = length PLTE data crc
    idat = length IDAT data crc
    chunk = length type data crc
    length = 4byte
    crc = 4byte
    data = byte*
    type =
        IHDR  文件头数据块            1  第一块
        cHRM  基色和白色点数据块      ?  在PLTE和IDAT之前
        gAMA  图像γ数据块             ?  在PLTE和IDAT之前
        sBIT  样本有效位数据块        ?  在PLTE和IDAT之前
        PLTE  调色板数据块            ?  在IDAT之前
        bKGD  背景颜色数据块          ?  在PLTE之后IDAT之前
        hIST  图像直方图数据块        ?  在PLTE之后IDAT之前
        tRNS  图像透明数据块          ?  在PLTE之后IDAT之前
        oFFs  (专用公共数据块)        ?  在IDAT之前
        pHYs  物理像素尺寸数据块      ?  在IDAT之前
        sCAL  (专用公共数据块)        ?  在IDAT之前
        IDAT  图像数据块              +  与其他IDAT连续
        tIME  图像最后修改时间数据块  ?  无限制
        tEXt  文本信息数据块          *  无限制
        zTXt  压缩文本数据块          *  无限制
        fRAc  (专用公共数据块)        *  无限制
        gIFg  (专用公共数据块)        *  无限制
        gIFt  (专用公共数据块)        *  无限制
        gIFx  (专用公共数据块)        *  无限制
        IEND  图像结束数据            1  最后一个数据块

