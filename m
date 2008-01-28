From: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCHv3 2.6.25] i2c: adds support for i2c bus on Freescale CPM1/CPM2
 controllers
Date: Mon, 28 Jan 2008 19:45:52 +0100
Message-ID: <479E22E0.9010105@scram.de>
References: <479A185D.6010406@scram.de> <386072610801280921q3e96bfc1v40ad09660c0f7ad8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757993AbYA1Sqi@vger.kernel.org>
In-Reply-To: <386072610801280921q3e96bfc1v40ad09660c0f7ad8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan Wu <cooloney.lkml@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, Jean Delvare <khali@linux-fr.org>, Kumar Gala <galak@kernel.crashing.org>, Vitaly Bordug <vitb@kernel.crashing.org>, "Kernel, Linux" <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Linux I2C <i2c@lm-sensors.org>, Jon Smirl <jonsmirl@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Hi Bryan,

>> +
>> +       /* register new adapter to i2c module... */
>> +
>> +       result = i2c_add_adapter(&cpm->adap);
> 
> As I was pointed before, please use the new style i2c driver interface:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=991dee591a99d035796a8c194eb1796cc020e142

AFAIK, the device tree currently doesn't provide an adapter id. If we're going to add this property, this would be
needed on other of_platform i2c drivers, as well.

Thanks,
Jochen
