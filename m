From: Adrian Fiergolski <Adrian.Fiergolski@cern.ch>
Subject: nested I2C muxes
Date: Thu, 19 Jan 2017 19:03:26 +0100
Message-ID: <595ed81b-546b-a60f-1bf1-b21f14c15b3c@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr50042.outbound.protection.outlook.com ([40.107.5.42]:43712
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751622AbdASSVm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 19 Jan 2017 13:21:42 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Hi,

I haven't found any information regarding support for nested i2c muxes.
Is the below device tree supported by the current driver ?

&i2c0 {
        status =3D "okay";
        clock-frequency =3D <400000>;
        pinctrl-names =3D "default";
        pinctrl-0 =3D <&pinctrl_i2c0_default>;

        i2cswitch@74 {
                compatible =3D "nxp,pca9548";
                #address-cells =3D <1>;
                #size-cells =3D <0>;
                reg =3D <0x74>;

                i2c@0 {
                        #address-cells =3D <1>;
                        #size-cells =3D <0>;
                        reg =3D <0>;
                        si570: clock-generator@5d {
                                #clock-cells =3D <0>;
                                compatible =3D "silabs,si570";
                                temperature-stability =3D <50>;
                                reg =3D <0x5d>;
                                factory-fout =3D <156250000>;
                                clock-frequency =3D <148500000>;
                        };
                };

                i2c@2 {
                        #address-cells =3D <1>;
                        #size-cells =3D <0>;
                        reg =3D <5>;
                        i2cswitch_hpc@74 {
                                         compatible =3D "nxp,pca9548";
                                         #address-cells =3D <1>;
                                         #size-cells =3D <0>;
                                         reg =3D <0x74>;
                                         hpc_caribou_sources_enable@76  {=

                                                                      =20
compatible=3D "nxp,pca9539";
                                                                      =20
#address-cells =3D <1>;
                                                                      =20
#size-cells =3D <0>;
                                                                      =20
reg =3D <0x76>;
                                         };
                        };

                };

        };

};

With such tree I am getting error

[2.173385] i2c i2c-2: of_i2c: invalid addr=3D0 on
/amba/i2c@e0004000/i2cswitch@74/i2c@2/i2cswitch_hpc@74


Regards,

Adrian Fiergolski
