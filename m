From: =?UTF-8?B?54K65rqiKOmYv+WwvOWFiOeUnyk=?= <kchengwy@gmail.com>
Subject: i2c-ismt: IRDPE error
Date: Tue, 28 Jun 2016 07:41:16 +0800
Message-ID: <CABnNLvhGxcStPQxoZCRbR8Het2m7P7CZkYXYVbTmsO33aRxsTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34355 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbcF0XlS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Jun 2016 19:41:18 -0400
Received: by mail-vk0-f66.google.com with SMTP id v6so47618vkb.1
        for <linux-i2c@vger.kernel.org>; Mon, 27 Jun 2016 16:41:17 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Hi everyone,

I=E2=80=99m working on a board that using intel iSMT controller to comm=
unicate
with custom I2C slave device.
But sometimes I got IRDPE error while reading data from device.

And I got information that there is a Errata about this error and has
a workaround.
Does anyone know the detail about that Errata ?
And have this workaround already be implemented in the latest i2c-ismt =
driver ?

Thanks.

Best regards
Kenny Cheng.

=3D=3D=3D IRDPE Error message =3D=3D=3D
=3D=3D=3D Kernel version 3.13.11 =3D=3D=3D
[   96.776427] priv->dma_buffer (after completion) - 06 24 00 00  24
01 A1 FF  FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF
=46F  FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF
=46F FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF  FF FF FF FF  FF
[   96.799780] Processing completed descriptor
[   96.804464] Descriptor struct:  ffff8802739ae010
[   96.809631]  tgtaddr_rw=3D0xFE
[   96.812846]  wr_len_cmd=3D0x07
[   96.816059]  rd_len=3D    0x28
[   96.819280]  control=3D   0x68
[   96.822503]  status=3D    0x00
[   96.825727]  retry=3D     0x00
[   96.828949]  rxbytes=3D   0x00
[   96.832171]  txbytes=3D   0x00
[   96.835393]  dptr_low=3D  0x73FCFB78
[   96.839198]  dptr_high=3D 0x00000002
[   96.842995] Dump of the iSMT General Registers
[   96.847969]   GCTRL.... : (0xffffc90000c74000)=3D0x00000000
[   96.854011]   SMTICL... : (0xffffc90000c74008)=3D0x0000000000000000
[   96.860830]   ERRINTMSK : (0xffffc90000c74010)=3D0x00000000
[   96.866871]   ERRAERMSK : (0xffffc90000c74014)=3D0x00000000
[   96.872905]   ERRSTS... : (0xffffc90000c74018)=3D0x00000200 <- IRDPE=
 Error
[   96.878948]   ERRINFO.. : (0xffffc90000c7401c)=3D0x00000029
[   96.884988] Dump of the iSMT Master Registers
[   96.889864]   MDBA..... : (0xffffc90000c74100)=3D0x00000002739AE000
[   96.896685]   MCTRL.... : (0xffffc90000c74108)=3D0x00020010
[   96.902728]   MSTS..... : (0xffffc90000c7410c)=3D0x00020000
[   96.908772]   MDS...... : (0xffffc90000c74110)=3D0x0000001F
[   96.914814]   RPOLICY.. : (0xffffc90000c74114)=3D0x00061020
[   96.920856]   TBBA..... : (0xffffc90000c74200)=3D0x0000000000000000
[   96.927668]   TCTRL.... : (0xffffc90000c74208)=3D0x00000010
[   96.933710]   TSTS..... : (0xffffc90000c7420c)=3D0x00000000
[   96.939752]   TBS...... : (0xffffc90000c74210)=3D0x00000000
[   96.945795]   HTHP..... : (0xffffc90000c74218)=3D0x00000000
[   96.951838]   FTTP..... : (0xffffc90000c7421c)=3D0x00000000
[   96.957880]   TRxCTRL.. : (0xffffc90000c74220)=3D0x00000058
[   96.963921]   TRxSTS... : (0xffffc90000c74224)=3D0x00000000
[   96.969955]   TACTRL... : (0xffffc90000c74228)=3D0x00000000
[   96.975998]   TPOLICY.. : (0xffffc90000c7422c)=3D0x0000001A
[   96.982041]   GPBRCTRL. : (0xffffc90000c74240)=3D0x00000089
[   96.988084]   GPBRDBUF. : (0xffffc90000c74244)=3D0x00000000
[   96.994126]   SMTARPCTRL: (0xffffc90000c74280)=3D0x00000000
[   97.000168]   UDID0.... : (0xffffc90000c74290)=3D0x8086000000000000
[   97.006989]   UUDID0... : (0xffffc90000c74298)=3D0x8108808600000024
[   97.013808]   UDID1.... : (0xffffc90000c742a0)=3D0x8086000000000001
[   97.020617]   UUDID1... : (0xffffc90000c742a8)=3D0x8108808600000024
[   97.027436]   SPGT..... : (0xffffc90000c74300)=3D0x40000005
[   97.033478]   SPMT..... : (0xffffc90000c74304)=3D0x08080000
[   97.039521]   SPST..... : (0xffffc90000c74308)=3D0x00000000
[   97.045563]   SMBFT.... : (0xffffc90000c7430c)=3D0x00002024
[   97.051604]   CLTC..... : (0xffffc90000c74310)=3D0x00000962
