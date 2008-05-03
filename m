From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] modpost: i2c aliases need no trailing wildcard
Date: Sat, 3 May 2008 14:50:55 +0200
Message-ID: <20080503145055.3cb9032a@hyperion.delvare>
References: <20080502203721.70c5dc09@hyperion.delvare>
	<481C58C0.4040107@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763431AbYECMvT@vger.kernel.org>
In-Reply-To: <481C58C0.4040107@scram.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jochen Friedrich <jochen@scram.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Kay Sievers <kay.sievers@vrfy.org>, Sam Ravnborg <sam@ravnborg.org>, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jochen,

On Sat, 03 May 2008 14:21:20 +0200, Jochen Friedrich wrote:
> Hi Jean,
> 
> > Here's a patch doing this. If nobody objects, I'll send it to Linus
> > through my i2c tree next week.
> 
> looks good to me:

Thanks for testing and reporting!

> #cat modules.alias 
> # Aliases extracted from modules themselves.
> alias i2c:dbox2-fp dbox2_fp
> alias of:N*T*Cfsl,cpm-i2c* i2c_cpm
> alias i2c:dummy i2c_core

I don't have this one, and I doubt it is really useful...

> alias i2c:saa7129 saa7127
> alias i2c:saa7128 saa7127
> alias i2c:saa7127 saa7127
> alias i2c:saa7126 saa7127

-- 
Jean Delvare
