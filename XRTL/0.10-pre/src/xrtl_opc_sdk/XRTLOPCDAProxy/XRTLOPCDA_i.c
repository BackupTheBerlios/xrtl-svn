
#pragma warning( disable: 4049 )  /* more than 64k source lines */

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 6.00.0347 */
/* at Fri Nov 01 18:23:40 2002
 */
/* Compiler settings for XRTLOPCDA.idl:
    Oicf, W1, Zp8, env=Win32 (32b run)
    protocol : dce , ms_ext, c_ext
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
//@@MIDL_FILE_HEADING(  )

#if !defined(_M_IA64) && !defined(_M_AMD64)

#ifdef __cplusplus
extern "C"{
#endif 


#include <rpc.h>
#include <rpcndr.h>

#ifdef _MIDL_USE_GUIDDEF_

#ifndef INITGUID
#define INITGUID
#include <guiddef.h>
#undef INITGUID
#else
#include <guiddef.h>
#endif

#define MIDL_DEFINE_GUID(type,name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) \
        DEFINE_GUID(name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8)

#else // !_MIDL_USE_GUIDDEF_

#ifndef __IID_DEFINED__
#define __IID_DEFINED__

typedef struct _IID
{
    unsigned long x;
    unsigned short s1;
    unsigned short s2;
    unsigned char  c[8];
} IID;

#endif // __IID_DEFINED__

#ifndef CLSID_DEFINED
#define CLSID_DEFINED
typedef IID CLSID;
#endif // CLSID_DEFINED

#define MIDL_DEFINE_GUID(type,name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) \
        const type name = {l,w1,w2,{b1,b2,b3,b4,b5,b6,b7,b8}}

#endif !_MIDL_USE_GUIDDEF_

MIDL_DEFINE_GUID(IID, IID_IXRTLOPCDA20Server,0xC9108B6D,0xB9A7,0x4396,0xBF,0x9F,0x55,0xF2,0x48,0x49,0xE9,0x20);


MIDL_DEFINE_GUID(IID, IID_IXRTLOPCDA20Group,0xD2ADCF12,0x1553,0x4040,0xAA,0x0F,0xB7,0x4E,0xDA,0x6F,0xE1,0xD2);


MIDL_DEFINE_GUID(IID, IID_IXRTLOPCDANameSpace,0xEF4B587B,0x7426,0x43C7,0x9C,0x6F,0xA5,0x13,0xE1,0x36,0x71,0x98);


MIDL_DEFINE_GUID(IID, IID_IXRTLOPCDANameSpaceItem,0x3C914D07,0x3FE2,0x4339,0xB5,0x62,0x6D,0x84,0x91,0x77,0xF7,0x87);


MIDL_DEFINE_GUID(IID, IID_IXRTLOPCDADataSource,0x5C389437,0x7A4D,0x4DB0,0x8E,0x02,0x15,0xFE,0x25,0x23,0xD9,0xB8);


MIDL_DEFINE_GUID(IID, LIBID_XRTLOPCDA,0xB27A21DD,0xE846,0x4CFF,0xB6,0x69,0xE2,0x9A,0x25,0x4A,0xEA,0xB1);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



#endif /* !defined(_M_IA64) && !defined(_M_AMD64)*/

