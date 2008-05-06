From: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] [POWERPC] Fix of_i2c include for module compilation
Date: Tue, 06 May 2008 20:39:37 +0200
Message-ID: <4820A5E9.8030204@scram.de>
References: <481C5DD0.5090503@scram.de> <18462.35282.374180.770237@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765274AbYEFSkA@vger.kernel.org>
In-Reply-To: <18462.35282.374180.770237@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: Kumar Gala <galak@kernel.crashing.org>, Jean Delvare <khali@linux-fr.org>, Scott Wood <scottwood@freescale.com>, "Kernel, Linux" <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Linux I2C <i2c@lm-sensors.org>, Jon Smirl <jonsmirl@gmail.com>, Laurent Pinchart <laurentp@cse-semaphore.com>, David Miller <davem@davemloft.net>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-i2c@vger.kernel.org

Hi Paul,

>> -#ifdef CONFIG_OF_I2C
>> +#if defined(CONFIG_OF_I2C) || defined(CONFIG_OF_I2C_MODULE)
>>  
>>  void of_register_i2c_devices(struct i2c_adapter *adap,
>>  			     struct device_node *adap_node);
> 
> Why do we have that ifdef there at all?  There's only that one
> external declaration within it, so the #ifdef and #endif could just be
> removed.  If the ifdef hadn't been there in the first place we
> wouldn't have had this problem.

You're right. I mainly copied from of_gpio.h without too much thinking :(.
I'll resend.

Thanks,
Jochen
