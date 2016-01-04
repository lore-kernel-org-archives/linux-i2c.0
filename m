From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 02/10] i2c-mux: move select and deselect ops to
 i2c_mux_core
Date: Tue, 5 Jan 2016 00:02:27 +0800
Message-ID: <201601050001.8PUnvf3k%fengguang.wu@intel.com>
References: <1451920215-29167-3-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451920215-29167-3-git-send-email-peda@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Peter Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@lysator.liu.se>
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

[auto build test WARNING on wsa/i2c/for-next]
[also build test WARNING on v4.4-rc8 next-20160104]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Rosin/i2c-mux-cleanup-and-locking-update/20160104-231355
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux i2c/for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:845:46: sparse: too many arguments for function i2c_add_mux_adapter
   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c: In function 'inv_mpu_probe':
   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:845:40: warning: passing argument 1 of 'i2c_add_mux_adapter' from incompatible pointer type [-Wincompatible-pointer-types]
     st->mux_adapter = i2c_add_mux_adapter(client->adapter,
                                           ^
   In file included from drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:26:0:
   include/linux/i2c-mux.h:53:21: note: expected 'struct i2c_mux_core *' but argument is of type 'struct i2c_adapter *'
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^
   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:847:12: warning: passing argument 3 of 'i2c_add_mux_adapter' makes integer from pointer without a cast [-Wint-conversion]
               indio_dev,
               ^
   In file included from drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:26:0:
   include/linux/i2c-mux.h:53:21: note: expected 'u32 {aka unsigned int}' but argument is of type 'struct iio_dev *'
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^
   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:845:20: error: too many arguments to function 'i2c_add_mux_adapter'
     st->mux_adapter = i2c_add_mux_adapter(client->adapter,
                       ^
   In file included from drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:26:0:
   include/linux/i2c-mux.h:53:21: note: declared here
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^
--
   include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/media/dvb-frontends/si2168.c:712:43: sparse: too many arguments for function i2c_add_mux_adapter
   drivers/media/dvb-frontends/si2168.c: In function 'si2168_probe':
   drivers/media/dvb-frontends/si2168.c:712:37: warning: passing argument 1 of 'i2c_add_mux_adapter' from incompatible pointer type [-Wincompatible-pointer-types]
     dev->adapter = i2c_add_mux_adapter(client->adapter, &client->dev,
                                        ^
   In file included from drivers/media/dvb-frontends/si2168_priv.h:23:0,
                    from drivers/media/dvb-frontends/si2168.c:17:
   include/linux/i2c-mux.h:53:21: note: expected 'struct i2c_mux_core *' but argument is of type 'struct i2c_adapter *'
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^
   drivers/media/dvb-frontends/si2168.c:713:4: warning: passing argument 3 of 'i2c_add_mux_adapter' makes integer from pointer without a cast [-Wint-conversion]
       client, 0, 0, 0, si2168_select, si2168_deselect);
       ^
   In file included from drivers/media/dvb-frontends/si2168_priv.h:23:0,
                    from drivers/media/dvb-frontends/si2168.c:17:
   include/linux/i2c-mux.h:53:21: note: expected 'u32 {aka unsigned int}' but argument is of type 'struct i2c_client *'
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^
   drivers/media/dvb-frontends/si2168.c:712:17: error: too many arguments to function 'i2c_add_mux_adapter'
     dev->adapter = i2c_add_mux_adapter(client->adapter, &client->dev,
                    ^
   In file included from drivers/media/dvb-frontends/si2168_priv.h:23:0,
                    from drivers/media/dvb-frontends/si2168.c:17:
   include/linux/i2c-mux.h:53:21: note: declared here
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^
--
   include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/media/dvb-frontends/m88ds3103.c:1470:47: sparse: too many arguments for function i2c_add_mux_adapter
   drivers/media/dvb-frontends/m88ds3103.c: In function 'm88ds3103_probe':
   drivers/media/dvb-frontends/m88ds3103.c:1470:41: warning: passing argument 1 of 'i2c_add_mux_adapter' from incompatible pointer type [-Wincompatible-pointer-types]
     dev->i2c_adapter = i2c_add_mux_adapter(client->adapter, &client->dev,
                                            ^
   In file included from drivers/media/dvb-frontends/m88ds3103_priv.h:24:0,
                    from drivers/media/dvb-frontends/m88ds3103.c:17:
   include/linux/i2c-mux.h:53:21: note: expected 'struct i2c_mux_core *' but argument is of type 'struct i2c_adapter *'
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^
   drivers/media/dvb-frontends/m88ds3103.c:1471:13: warning: passing argument 3 of 'i2c_add_mux_adapter' makes integer from pointer without a cast [-Wint-conversion]
                dev, 0, 0, 0, m88ds3103_select,
                ^
   In file included from drivers/media/dvb-frontends/m88ds3103_priv.h:24:0,
                    from drivers/media/dvb-frontends/m88ds3103.c:17:
   include/linux/i2c-mux.h:53:21: note: expected 'u32 {aka unsigned int}' but argument is of type 'struct m88ds3103_dev *'
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^
   drivers/media/dvb-frontends/m88ds3103.c:1470:21: error: too many arguments to function 'i2c_add_mux_adapter'
     dev->i2c_adapter = i2c_add_mux_adapter(client->adapter, &client->dev,
                        ^
   In file included from drivers/media/dvb-frontends/m88ds3103_priv.h:24:0,
                    from drivers/media/dvb-frontends/m88ds3103.c:17:
   include/linux/i2c-mux.h:53:21: note: declared here
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^
--
   include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/media/dvb-frontends/rtl2830.c:868:43: sparse: too many arguments for function i2c_add_mux_adapter
   drivers/media/dvb-frontends/rtl2830.c: In function 'rtl2830_probe':
   drivers/media/dvb-frontends/rtl2830.c:868:37: warning: passing argument 1 of 'i2c_add_mux_adapter' from incompatible pointer type [-Wincompatible-pointer-types]
     dev->adapter = i2c_add_mux_adapter(client->adapter, &client->dev,
                                        ^
   In file included from drivers/media/dvb-frontends/rtl2830_priv.h:24:0,
                    from drivers/media/dvb-frontends/rtl2830.c:18:
   include/linux/i2c-mux.h:53:21: note: expected 'struct i2c_mux_core *' but argument is of type 'struct i2c_adapter *'
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^
   drivers/media/dvb-frontends/rtl2830.c:869:4: warning: passing argument 3 of 'i2c_add_mux_adapter' makes integer from pointer without a cast [-Wint-conversion]
       client, 0, 0, 0, rtl2830_select, NULL);
       ^
   In file included from drivers/media/dvb-frontends/rtl2830_priv.h:24:0,
                    from drivers/media/dvb-frontends/rtl2830.c:18:
   include/linux/i2c-mux.h:53:21: note: expected 'u32 {aka unsigned int}' but argument is of type 'struct i2c_client *'
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^
   drivers/media/dvb-frontends/rtl2830.c:868:17: error: too many arguments to function 'i2c_add_mux_adapter'
     dev->adapter = i2c_add_mux_adapter(client->adapter, &client->dev,
                    ^
   In file included from drivers/media/dvb-frontends/rtl2830_priv.h:24:0,
                    from drivers/media/dvb-frontends/rtl2830.c:18:
   include/linux/i2c-mux.h:53:21: note: declared here
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^
--
   include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/media/dvb-frontends/rtl2832.c:1265:53: sparse: too many arguments for function i2c_add_mux_adapter
   drivers/media/dvb-frontends/rtl2832.c: In function 'rtl2832_probe':
   drivers/media/dvb-frontends/rtl2832.c:1265:47: warning: passing argument 1 of 'i2c_add_mux_adapter' from incompatible pointer type [-Wincompatible-pointer-types]
     dev->i2c_adapter_tuner = i2c_add_mux_adapter(i2c, &i2c->dev, dev,
                                                  ^
   In file included from drivers/media/dvb-frontends/rtl2832.h:26:0,
                    from drivers/media/dvb-frontends/rtl2832_priv.h:31,
                    from drivers/media/dvb-frontends/rtl2832.c:22:
   include/linux/i2c-mux.h:53:21: note: expected 'struct i2c_mux_core *' but argument is of type 'struct i2c_adapter *'
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^
   drivers/media/dvb-frontends/rtl2832.c:1265:63: warning: passing argument 3 of 'i2c_add_mux_adapter' makes integer from pointer without a cast [-Wint-conversion]
     dev->i2c_adapter_tuner = i2c_add_mux_adapter(i2c, &i2c->dev, dev,
                                                                  ^
   In file included from drivers/media/dvb-frontends/rtl2832.h:26:0,
                    from drivers/media/dvb-frontends/rtl2832_priv.h:31,
                    from drivers/media/dvb-frontends/rtl2832.c:22:
   include/linux/i2c-mux.h:53:21: note: expected 'u32 {aka unsigned int}' but argument is of type 'struct rtl2832_dev *'
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^
   drivers/media/dvb-frontends/rtl2832.c:1265:27: error: too many arguments to function 'i2c_add_mux_adapter'
     dev->i2c_adapter_tuner = i2c_add_mux_adapter(i2c, &i2c->dev, dev,
                              ^
   In file included from drivers/media/dvb-frontends/rtl2832.h:26:0,
                    from drivers/media/dvb-frontends/rtl2832_priv.h:31,
                    from drivers/media/dvb-frontends/rtl2832.c:22:
   include/linux/i2c-mux.h:53:21: note: declared here
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^
--
   include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/media/usb/cx231xx/cx231xx-i2c.c:574:56: sparse: too many arguments for function i2c_add_mux_adapter
   drivers/media/usb/cx231xx/cx231xx-i2c.c: In function 'cx231xx_i2c_mux_register':
   drivers/media/usb/cx231xx/cx231xx-i2c.c:574:50: warning: passing argument 1 of 'i2c_add_mux_adapter' from incompatible pointer type [-Wincompatible-pointer-types]
     dev->i2c_mux_adap[mux_no] = i2c_add_mux_adapter(i2c_parent,
                                                     ^
   In file included from drivers/media/usb/cx231xx/cx231xx-i2c.c:27:0:
   include/linux/i2c-mux.h:53:21: note: expected 'struct i2c_mux_core *' but argument is of type 'struct i2c_adapter *'
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^
   drivers/media/usb/cx231xx/cx231xx-i2c.c:576:5: warning: passing argument 3 of 'i2c_add_mux_adapter' makes integer from pointer without a cast [-Wint-conversion]
        dev /* mux_priv */,
        ^
   In file included from drivers/media/usb/cx231xx/cx231xx-i2c.c:27:0:
   include/linux/i2c-mux.h:53:21: note: expected 'u32 {aka unsigned int}' but argument is of type 'struct cx231xx *'
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^
   drivers/media/usb/cx231xx/cx231xx-i2c.c:574:30: error: too many arguments to function 'i2c_add_mux_adapter'
     dev->i2c_mux_adap[mux_no] = i2c_add_mux_adapter(i2c_parent,
                                 ^
   In file included from drivers/media/usb/cx231xx/cx231xx-i2c.c:27:0:
   include/linux/i2c-mux.h:53:21: note: declared here
    struct i2c_adapter *i2c_add_mux_adapter(struct i2c_mux_core *muxc,
                        ^

vim +845 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c

452204ae Sachin Kamat        2013-07-30  829  		return result;
09a642b7 Ge Gao              2013-02-02  830  	}
09a642b7 Ge Gao              2013-02-02  831  	result = inv_mpu6050_probe_trigger(indio_dev);
09a642b7 Ge Gao              2013-02-02  832  	if (result) {
09a642b7 Ge Gao              2013-02-02  833  		dev_err(&st->client->dev, "trigger probe fail %d\n", result);
09a642b7 Ge Gao              2013-02-02  834  		goto out_unreg_ring;
09a642b7 Ge Gao              2013-02-02  835  	}
09a642b7 Ge Gao              2013-02-02  836  
09a642b7 Ge Gao              2013-02-02  837  	INIT_KFIFO(st->timestamps);
09a642b7 Ge Gao              2013-02-02  838  	spin_lock_init(&st->time_stamp_lock);
09a642b7 Ge Gao              2013-02-02  839  	result = iio_device_register(indio_dev);
09a642b7 Ge Gao              2013-02-02  840  	if (result) {
09a642b7 Ge Gao              2013-02-02  841  		dev_err(&st->client->dev, "IIO register fail %d\n", result);
09a642b7 Ge Gao              2013-02-02  842  		goto out_remove_trigger;
09a642b7 Ge Gao              2013-02-02  843  	}
09a642b7 Ge Gao              2013-02-02  844  
3a2ecc3d Srinivas Pandruvada 2014-12-05 @845  	st->mux_adapter = i2c_add_mux_adapter(client->adapter,
3a2ecc3d Srinivas Pandruvada 2014-12-05  846  					      &client->dev,
3a2ecc3d Srinivas Pandruvada 2014-12-05  847  					      indio_dev,
3a2ecc3d Srinivas Pandruvada 2014-12-05  848  					      0, 0, 0,
3a2ecc3d Srinivas Pandruvada 2014-12-05  849  					      inv_mpu6050_select_bypass,
3a2ecc3d Srinivas Pandruvada 2014-12-05  850  					      inv_mpu6050_deselect_bypass);
3a2ecc3d Srinivas Pandruvada 2014-12-05  851  	if (!st->mux_adapter) {
3a2ecc3d Srinivas Pandruvada 2014-12-05  852  		result = -ENODEV;
3a2ecc3d Srinivas Pandruvada 2014-12-05  853  		goto out_unreg_device;

:::::: The code at line 845 was first introduced by commit
:::::: 3a2ecc3d2dce6e051b6afc319bb380c829e4e4fd iio: imu: inv_mpu6050: Add i2c mux for by pass

:::::: TO: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
:::::: CC: Jonathan Cameron <jic23@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
