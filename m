From: Jochen Friedrich <jochen@scram.de>
Subject: Re: [i2c] [PATCH] modpost: i2c aliases need no trailing wildcard
Date: Sat, 03 May 2008 14:21:20 +0200
Message-ID: <481C58C0.4040107@scram.de>
References: <20080502203721.70c5dc09@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762787AbYECMVh@vger.kernel.org>
In-Reply-To: <20080502203721.70c5dc09@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Kay Sievers <kay.sievers@vrfy.org>, Sam Ravnborg <sam@ravnborg.org>, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

> Here's a patch doing this. If nobody objects, I'll send it to Linus
> through my i2c tree next week.

looks good to me:

#cat modules.alias 
# Aliases extracted from modules themselves.
alias i2c:dbox2-fp dbox2_fp
alias of:N*T*Cfsl,cpm-i2c* i2c_cpm
alias i2c:dummy i2c_core
alias i2c:saa7129 saa7127
alias i2c:saa7128 saa7127
alias i2c:saa7127 saa7127
alias i2c:saa7126 saa7127

Thanks,
Jochen
