From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2] i2ctools: Add capability to write block command
Date: Sat, 29 Jan 2011 09:39:03 -0800
Message-ID: <20110129173903.GA29184@ericsson.com>
References: <20110125162106.GA8024@ericsson.com>
 <20110125174922.4c802f49@endymion.delvare>
 <20110127160058.GA16853@ericsson.com>
 <20110127175908.488edda3@endymion.delvare>
 <20110127195842.GA17775@ericsson.com>
 <20110129174354.2b146a19@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110129174354.2b146a19-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Sat, Jan 29, 2011 at 11:43:54AM -0500, Jean Delvare wrote:
[ ...]
> 
> Other than that, it looks alright, feel free to commit (I've just added
> you to the list of committers - same credentials as lm-sensors
> repository.)
> 
Thanks, and done.

> Next, I think we can remove the old method for setting the mask. Then
> we'll see if some code cleanup or reorganization makes sense.
> 
I'll see what I can do.

Guenter
