From: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCHv4 2.6.25] i2c: adds support for i2c bus on Freescale CPM1/CPM2
 controllers
Date: Fri, 22 Feb 2008 12:16:16 +0100
Message-ID: <47BEAF00.50106@scram.de>
References: <47A1C4E9.4000003@scram.de> <20080221130520.12b01553@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932186AbYBVLTy@vger.kernel.org>
In-Reply-To: <20080221130520.12b01553@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Scott Wood <scottwood@freescale.com>, Kumar Gala <galak@kernel.crashing.org>, Vitaly Bordug <vitb@kernel.crashing.org>, linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

>> +/*
>> + * Wait for patch from Jon Smirl
>> + * #include "powerpc-common.h"
>> + */
> 
> It doesn't make sense to merge this comment upstream.

I know you don't like the patch from Jon Smirl and you also explained your reasons.
Fortunately, I2c no longer uses numeric device IDs but names. So what are the alternatives?

1. modify the I2c subsystem to accept OF names additionally to I2c names (proposed by Jon smirl).
2. record the I2c name in the dts tree, either as seperate tag (like linux,i2c-name="<i2c-name>")
   or as additional compatible entry (like compatible="...", "linux,<i2c-name>").
3. use a glue layer with a translation map.

What is the preferred way to do this?

Thanks,
Jochen
