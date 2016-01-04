From: kbuild test robot <fengguang.wu@intel.com>
Subject: [linux-review:Peter-Rosin/i2c-mux-cleanup-and-locking-update/20160104-231355] 8627e12bd6d3fc7506656f026a23afae52d12c73 BUILD DONE
Date: Tue, 05 Jan 2016 00:13:32 +0800
Message-ID: <568a9a2c./f52eMGHRPq5ELHe%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Peter Rosin <peda@lysator.liu.se>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Peter Korsgaard <peter.korsgaard@barco.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

https://github.com/0day-ci/linux  Peter-Rosin/i2c-mux-cleanup-and-locki=
ng-update/20160104-231355
8627e12bd6d3fc7506656f026a23afae52d12c73  i2c: pca954x: get rid of the =
i2c deadlock workaround

drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:845:18: warning: assignment =
makes pointer from integer without a cast [-Wint-conversion]
drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:845:20: error: too many argu=
ments to function 'i2c_add_mux_adapter'
drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:845:40: warning: passing arg=
ument 1 of 'i2c_add_mux_adapter' from incompatible pointer type [-Winco=
mpatible-pointer-types]
drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:845:46: sparse: too many arg=
uments for function i2c_add_mux_adapter
drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:846:12: warning: passing arg=
ument 2 of 'i2c_add_mux_adapter' makes integer from pointer without a c=
ast [-Wint-conversion]
drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:847:12: warning: passing arg=
ument 3 of 'i2c_add_mux_adapter' makes integer from pointer without a c=
ast [-Wint-conversion]
drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:863:2: error: implicit decla=
ration of function 'i2c_del_mux_adapter' [-Werror=3Dimplicit-function-d=
eclaration]
drivers/media/dvb-frontends/m88ds3103.c:1470:19: warning: assignment ma=
kes pointer from integer without a cast [-Wint-conversion]
drivers/media/dvb-frontends/m88ds3103.c:1470:21: error: too many argume=
nts to function 'i2c_add_mux_adapter'
drivers/media/dvb-frontends/m88ds3103.c:1470:41: warning: passing argum=
ent 1 of 'i2c_add_mux_adapter' from incompatible pointer type
drivers/media/dvb-frontends/m88ds3103.c:1470:41: warning: passing argum=
ent 1 of 'i2c_add_mux_adapter' from incompatible pointer type [-Wincomp=
atible-pointer-types]
drivers/media/dvb-frontends/m88ds3103.c:1470:47: sparse: too many argum=
ents for function i2c_add_mux_adapter
drivers/media/dvb-frontends/m88ds3103.c:1470:58: warning: passing argum=
ent 2 of 'i2c_add_mux_adapter' makes integer from pointer without a cas=
t
drivers/media/dvb-frontends/m88ds3103.c:1470:58: warning: passing argum=
ent 2 of 'i2c_add_mux_adapter' makes integer from pointer without a cas=
t [-Wint-conversion]
drivers/media/dvb-frontends/m88ds3103.c:1471:13: warning: passing argum=
ent 3 of 'i2c_add_mux_adapter' makes integer from pointer without a cas=
t [-Wint-conversion]
drivers/media/dvb-frontends/m88ds3103.c:1505:2: error: implicit declara=
tion of function 'i2c_del_mux_adapter' [-Werror=3Dimplicit-function-dec=
laration]
drivers/media/dvb-frontends/rtl2830.c:868:15: warning: assignment makes=
 pointer from integer without a cast [-Wint-conversion]
drivers/media/dvb-frontends/rtl2830.c:868:17: error: too many arguments=
 to function 'i2c_add_mux_adapter'
drivers/media/dvb-frontends/rtl2830.c:868:37: warning: passing argument=
 1 of 'i2c_add_mux_adapter' from incompatible pointer type
drivers/media/dvb-frontends/rtl2830.c:868:37: warning: passing argument=
 1 of 'i2c_add_mux_adapter' from incompatible pointer type [-Wincompati=
ble-pointer-types]
drivers/media/dvb-frontends/rtl2830.c:868:43: sparse: too many argument=
s for function i2c_add_mux_adapter
drivers/media/dvb-frontends/rtl2830.c:868:54: warning: passing argument=
 2 of 'i2c_add_mux_adapter' makes integer from pointer without a cast
drivers/media/dvb-frontends/rtl2830.c:868:54: warning: passing argument=
 2 of 'i2c_add_mux_adapter' makes integer from pointer without a cast [=
-Wint-conversion]
drivers/media/dvb-frontends/rtl2830.c:869:4: warning: passing argument =
3 of 'i2c_add_mux_adapter' makes integer from pointer without a cast [-=
Wint-conversion]
drivers/media/dvb-frontends/rtl2830.c:903:2: error: implicit declaratio=
n of function 'i2c_del_mux_adapter' [-Werror=3Dimplicit-function-declar=
ation]
drivers/media/dvb-frontends/rtl2832.c:1265:53: sparse: too many argumen=
ts for function i2c_add_mux_adapter
drivers/media/dvb-frontends/si2168.c:712:17: error: too many arguments =
to function 'i2c_add_mux_adapter'
drivers/media/dvb-frontends/si2168.c:712:37: warning: passing argument =
1 of 'i2c_add_mux_adapter' from incompatible pointer type
drivers/media/dvb-frontends/si2168.c:712:37: warning: passing argument =
1 of 'i2c_add_mux_adapter' from incompatible pointer type [-Wincompatib=
le-pointer-types]
drivers/media/dvb-frontends/si2168.c:712:43: sparse: too many arguments=
 for function i2c_add_mux_adapter
drivers/media/dvb-frontends/si2168.c:712:54: warning: passing argument =
2 of 'i2c_add_mux_adapter' makes integer from pointer without a cast
drivers/media/dvb-frontends/si2168.c:712:54: warning: passing argument =
2 of 'i2c_add_mux_adapter' makes integer from pointer without a cast [-=
Wint-conversion]
drivers/media/dvb-frontends/si2168.c:713:4: warning: passing argument 3=
 of 'i2c_add_mux_adapter' makes integer from pointer without a cast [-W=
int-conversion]
drivers/media/usb/cx231xx/cx231xx-i2c.c:574:56: sparse: too many argume=
nts for function i2c_add_mux_adapter
drivers/of/unittest.c:1730:16: warning: assignment makes pointer from i=
nteger without a cast [-Wint-conversion]
drivers/of/unittest.c:1730:18: error: too many arguments to function 'i=
2c_add_mux_adapter'
drivers/of/unittest.c:1730:38: warning: passing argument 1 of 'i2c_add_=
mux_adapter' from incompatible pointer type [-Wincompatible-pointer-typ=
es]
drivers/of/unittest.c:1730:49: warning: passing argument 3 of 'i2c_add_=
mux_adapter' makes integer from pointer without a cast [-Wint-conversio=
n]
drivers/of/unittest.c:1735:5: error: implicit declaration of function '=
i2c_del_mux_adapter' [-Werror=3Dimplicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
=E2=94=9C=E2=94=80=E2=94=80 i386-allmodconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:error:implicit-declaration-of-function-i2c_del_mu=
x_adapter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:error:too-many-arguments-to-function-i2c_add_mux_=
adapter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:warning:assignment-makes-pointer-from-integer-wit=
hout-a-cast
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:warning:passing-argument-of-i2c_add_mux_adapter-f=
rom-incompatible-pointer-type
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:warning:passing-argument-of-i2c_add_mux_adapter-m=
akes-integer-from-pointer-without-a-cast
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-m88ds3103.c:error:implicit-declaration-of-function-i2c_del_mux_a=
dapter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-m88ds3103.c:error:too-many-arguments-to-function-i2c_add_mux_ada=
pter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-m88ds3103.c:warning:assignment-makes-pointer-from-integer-withou=
t-a-cast
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-m88ds3103.c:warning:passing-argument-of-i2c_add_mux_adapter-from=
-incompatible-pointer-type
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-m88ds3103.c:warning:passing-argument-of-i2c_add_mux_adapter-make=
s-integer-from-pointer-without-a-cast
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2830.c:error:implicit-declaration-of-function-i2c_del_mux_ada=
pter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2830.c:error:too-many-arguments-to-function-i2c_add_mux_adapt=
er
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2830.c:warning:assignment-makes-pointer-from-integer-without-=
a-cast
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2830.c:warning:passing-argument-of-i2c_add_mux_adapter-from-i=
ncompatible-pointer-type
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2830.c:warning:passing-argument-of-i2c_add_mux_adapter-makes-=
integer-from-pointer-without-a-cast
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-si2168.c:error:too-many-arguments-to-function-i2c_add_mux_adapte=
r
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-si2168.c:warning:passing-argument-of-i2c_add_mux_adapter-from-in=
compatible-pointer-type
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-si2168.c:warning:passing-argument-of-i2c_add_mux_adapter-makes-i=
nteger-from-pointer-without-a-cast
=E2=94=9C=E2=94=80=E2=94=80 i386-randconfig-i0-01042049
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:error:implicit-declaration-of-function-i2c_del_mu=
x_adapter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:error:too-many-arguments-to-function-i2c_add_mux_=
adapter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:warning:assignment-makes-pointer-from-integer-wit=
hout-a-cast
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:warning:passing-argument-of-i2c_add_mux_adapter-f=
rom-incompatible-pointer-type
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:warning:passing-argument-of-i2c_add_mux_adapter-m=
akes-integer-from-pointer-without-a-cast
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-of-unittest.c=
:error:implicit-declaration-of-function-i2c_del_mux_adapter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-of-unittest.c=
:error:too-many-arguments-to-function-i2c_add_mux_adapter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-of-unittest.c=
:warning:assignment-makes-pointer-from-integer-without-a-cast
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-of-unittest.c=
:warning:passing-argument-of-i2c_add_mux_adapter-from-incompatible-poin=
ter-type
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 drivers-of-unittest.c=
:warning:passing-argument-of-i2c_add_mux_adapter-makes-integer-from-poi=
nter-without-a-cast
=E2=94=9C=E2=94=80=E2=94=80 i386-randconfig-s1-201601
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:warning:passing-argument-of-i2c_add_mux_adapter-f=
rom-incompatible-pointer-type
=E2=94=9C=E2=94=80=E2=94=80 x86_64-allmodconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:sparse:too-many-arguments-for-function-i2c_add_mu=
x_adapter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-m88ds3103.c:sparse:too-many-arguments-for-function-i2c_add_mux_a=
dapter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-m88ds3103.c:warning:passing-argument-of-i2c_add_mux_adapter-from=
-incompatible-pointer-type
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2830.c:sparse:too-many-arguments-for-function-i2c_add_mux_ada=
pter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2830.c:warning:passing-argument-of-i2c_add_mux_adapter-from-i=
ncompatible-pointer-type
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2832.c:sparse:too-many-arguments-for-function-i2c_add_mux_ada=
pter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-si2168.c:sparse:too-many-arguments-for-function-i2c_add_mux_adap=
ter
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 drivers-media-usb-cx2=
31xx-cx231xx-i2c.c:sparse:too-many-arguments-for-function-i2c_add_mux_a=
dapter
=E2=94=9C=E2=94=80=E2=94=80 x86_64-randconfig-i0-201601
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-m88ds3103.c:error:implicit-declaration-of-function-i2c_del_mux_a=
dapter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-m88ds3103.c:error:too-many-arguments-to-function-i2c_add_mux_ada=
pter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-m88ds3103.c:warning:assignment-makes-pointer-from-integer-withou=
t-a-cast
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-m88ds3103.c:warning:passing-argument-of-i2c_add_mux_adapter-from=
-incompatible-pointer-type
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-m88ds3103.c:warning:passing-argument-of-i2c_add_mux_adapter-make=
s-integer-from-pointer-without-a-cast
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2830.c:error:implicit-declaration-of-function-i2c_del_mux_ada=
pter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2830.c:error:too-many-arguments-to-function-i2c_add_mux_adapt=
er
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2830.c:warning:assignment-makes-pointer-from-integer-without-=
a-cast
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2830.c:warning:passing-argument-of-i2c_add_mux_adapter-from-i=
ncompatible-pointer-type
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2830.c:warning:passing-argument-of-i2c_add_mux_adapter-makes-=
integer-from-pointer-without-a-cast
=E2=94=9C=E2=94=80=E2=94=80 x86_64-randconfig-n0-01050002
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:error:implicit-declaration-of-function-i2c_del_mu=
x_adapter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:error:too-many-arguments-to-function-i2c_add_mux_=
adapter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:warning:assignment-makes-pointer-from-integer-wit=
hout-a-cast
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:warning:passing-argument-of-i2c_add_mux_adapter-f=
rom-incompatible-pointer-type
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:warning:passing-argument-of-i2c_add_mux_adapter-m=
akes-integer-from-pointer-without-a-cast
=E2=94=9C=E2=94=80=E2=94=80 x86_64-randconfig-s3-01042359
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-m88ds3103.c:error:implicit-declaration-of-function-i2c_del_mux_a=
dapter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-m88ds3103.c:error:too-many-arguments-to-function-i2c_add_mux_ada=
pter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-m88ds3103.c:warning:assignment-makes-pointer-from-integer-withou=
t-a-cast
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-m88ds3103.c:warning:passing-argument-of-i2c_add_mux_adapter-from=
-incompatible-pointer-type
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-m88ds3103.c:warning:passing-argument-of-i2c_add_mux_adapter-make=
s-integer-from-pointer-without-a-cast
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2830.c:error:implicit-declaration-of-function-i2c_del_mux_ada=
pter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2830.c:error:too-many-arguments-to-function-i2c_add_mux_adapt=
er
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2830.c:warning:assignment-makes-pointer-from-integer-without-=
a-cast
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2830.c:warning:passing-argument-of-i2c_add_mux_adapter-from-i=
ncompatible-pointer-type
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-rtl2830.c:warning:passing-argument-of-i2c_add_mux_adapter-makes-=
integer-from-pointer-without-a-cast
=E2=94=9C=E2=94=80=E2=94=80 x86_64-randconfig-s4-01042328
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-si2168.c:error:too-many-arguments-to-function-i2c_add_mux_adapte=
r
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-si2168.c:warning:passing-argument-of-i2c_add_mux_adapter-from-in=
compatible-pointer-type
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 drivers-media-dvb-fro=
ntends-si2168.c:warning:passing-argument-of-i2c_add_mux_adapter-makes-i=
nteger-from-pointer-without-a-cast
=E2=94=9C=E2=94=80=E2=94=80 x86_64-randconfig-s4-01042359
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:error:implicit-declaration-of-function-i2c_del_mu=
x_adapter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:error:too-many-arguments-to-function-i2c_add_mux_=
adapter
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:warning:assignment-makes-pointer-from-integer-wit=
hout-a-cast
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:warning:passing-argument-of-i2c_add_mux_adapter-f=
rom-incompatible-pointer-type
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 drivers-iio-imu-inv_m=
pu6050-inv_mpu_core.c:warning:passing-argument-of-i2c_add_mux_adapter-m=
akes-integer-from-pointer-without-a-cast
=E2=94=94=E2=94=80=E2=94=80 x86_64-rhel
    =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-frontends-m88ds3103.c=
:error:too-many-arguments-to-function-i2c_add_mux_adapter
    =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-frontends-m88ds3103.c=
:warning:passing-argument-of-i2c_add_mux_adapter-from-incompatible-poin=
ter-type
    =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-frontends-m88ds3103.c=
:warning:passing-argument-of-i2c_add_mux_adapter-makes-integer-from-poi=
nter-without-a-cast
    =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-frontends-rtl2830.c:e=
rror:too-many-arguments-to-function-i2c_add_mux_adapter
    =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-frontends-rtl2830.c:w=
arning:passing-argument-of-i2c_add_mux_adapter-from-incompatible-pointe=
r-type
    =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-frontends-rtl2830.c:w=
arning:passing-argument-of-i2c_add_mux_adapter-makes-integer-from-point=
er-without-a-cast
    =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-frontends-si2168.c:er=
ror:too-many-arguments-to-function-i2c_add_mux_adapter
    =E2=94=9C=E2=94=80=E2=94=80 drivers-media-dvb-frontends-si2168.c:wa=
rning:passing-argument-of-i2c_add_mux_adapter-from-incompatible-pointer=
-type
    =E2=94=94=E2=94=80=E2=94=80 drivers-media-dvb-frontends-si2168.c:wa=
rning:passing-argument-of-i2c_add_mux_adapter-makes-integer-from-pointe=
r-without-a-cast

elapsed time: 57m

configs tested: 120

x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                           allmodconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                       imx_v6_v7_defconfig
arm                                  iop-adma
arm                          marzen_defconfig
arm                          prima2_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                       spear13xx_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64               randconfig-x017-01041832
x86_64               randconfig-x011-01041832
x86_64               randconfig-x015-01041832
x86_64               randconfig-x010-01041832
x86_64               randconfig-x016-01041832
x86_64               randconfig-x013-01041832
x86_64               randconfig-x018-01041832
x86_64               randconfig-x019-01041832
x86_64               randconfig-x012-01041832
x86_64               randconfig-x014-01041832
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201601
i386                     randconfig-s1-201601
x86_64                 randconfig-s3-01042359
x86_64                 randconfig-s4-01042359
x86_64                 randconfig-s5-01042359
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201601
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i0-01042049
i386                   randconfig-i1-01042049
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                               tinyconfig
arm                             pxa_defconfig
arm                          simpad_defconfig
powerpc                          alldefconfig
powerpc                     redwood_defconfig
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201601
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-n0-01050002
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64               randconfig-x007-01040711
x86_64               randconfig-x005-01040711
x86_64               randconfig-x003-01040711
x86_64               randconfig-x001-01040711
x86_64               randconfig-x004-01040711
x86_64               randconfig-x009-01040711
x86_64               randconfig-x002-01040711
x86_64               randconfig-x000-01040711
x86_64               randconfig-x008-01040711
x86_64               randconfig-x006-01040711
i386                     randconfig-r0-201601
i386                 randconfig-x005-01040616
i386                 randconfig-x003-01040616
i386                 randconfig-x002-01040616
i386                 randconfig-x001-01040616
i386                 randconfig-x008-01040616
i386                 randconfig-x000-01040616
i386                 randconfig-x009-01040616
i386                 randconfig-x006-01040616
i386                 randconfig-x004-01040616
i386                 randconfig-x007-01040616

Thanks,
=46engguang
