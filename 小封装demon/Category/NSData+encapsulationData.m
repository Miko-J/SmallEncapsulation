//
//  NSData+encapsulationData.m
//  1111111111
//
//  Created by niujinfeng on 17/4/13.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "NSData+encapsulationData.h"

@implementation NSData (encapsulationData)

//CRC 16校验
+ (instancetype) getCrcVerfityCode: (NSData *)data{
    int crcWord = 0x0000ffff;
    Byte *dataArray = (Byte *)[data bytes];
    for (int i = 0; i < data.length; i ++) {
        Byte byte = dataArray[i];
        crcWord ^= (int)byte & 0x000000ff;
        for (int j = 0; j < 8; j ++) {
            if ((crcWord & 0x00000001) == 1) {
                crcWord = crcWord >> 1;
                crcWord = crcWord ^ 0x0000A001;
            }else{
                crcWord = (crcWord >> 1);
            }
        }
    }
    Byte crch = (Byte)0xff & (crcWord >> 8);
    Byte crcl = (Byte)0xff & crcWord;
    Byte arraycrc[] = {crch,crcl};
    NSData *datacrc = [[NSData alloc] initWithBytes:arraycrc length:sizeof(arraycrc)];
    return datacrc;
}

@end
