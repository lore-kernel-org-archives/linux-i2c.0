From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 4/4] i2c: i801: Instantiate SPD EEPROMs automatically
Date: Mon, 14 Oct 2019 20:02:52 +0200
Message-ID: <20191014200252.7cc9c800@endymion>
References: <20191014114146.08b58f16@endymion>
        <201910141830.Jm52N2ts%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201910141830.Jm52N2ts%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@lists.01.org, Linux I2C <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On Mon, 14 Oct 2019 18:22:15 +0800, kbuild test robot wrote:
> Hi Jean,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.4-rc3 next-20191011]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Jean-Delvare/Instantiate-SPD-EEPROMs-at-boot-on-x86/20191014-174252
> config: i386-defconfig (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/i2c/busses/i2c-i801.c: In function 'i801_probe_optional_slaves':
> >> drivers/i2c/busses/i2c-i801.c:1319:11: error: 'struct i801_priv' has no member named 'mux_drvdata'  
>      if (!priv->mux_drvdata)
>               ^~
> 
> vim +1319 drivers/i2c/busses/i2c-i801.c
> 
>   1295	
>   1296	/* Register optional slaves */
>   1297	static void i801_probe_optional_slaves(struct i801_priv *priv)
>   1298	{
>   1299		/* Only register slaves on main SMBus channel */
>   1300		if (priv->features & FEATURE_IDF)
>   1301			return;
>   1302	
>   1303		if (apanel_addr) {
>   1304			struct i2c_board_info info;
>   1305	
>   1306			memset(&info, 0, sizeof(struct i2c_board_info));
>   1307			info.addr = apanel_addr;
>   1308			strlcpy(info.type, "fujitsu_apanel", I2C_NAME_SIZE);
>   1309			i2c_new_device(&priv->adapter, &info);
>   1310		}
>   1311	
>   1312		if (dmi_name_in_vendors("FUJITSU"))
>   1313			dmi_walk(dmi_check_onboard_devices, &priv->adapter);
>   1314	
>   1315		if (is_dell_system_with_lis3lv02d())
>   1316			register_dell_lis3lv02d_i2c_device(priv);
>   1317	
>   1318		/* Instantiate SPD EEPROMs unless the SMBus is multiplexed */
> > 1319		if (!priv->mux_drvdata)  
>   1320			i2c_register_spd(&priv->adapter);
>   1321	}
>   1322	#else
>   1323	static void __init input_apanel_init(void) {}
>   1324	static void i801_probe_optional_slaves(struct i801_priv *priv) {}
>   1325	#endif	/* CONFIG_X86 && CONFIG_DMI */
>   1326	

Fixed, thanks.

-- 
Jean Delvare
SUSE L3 Support
