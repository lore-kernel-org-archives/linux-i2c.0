From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: therm_adt746x: attach_adapter method is deprecated (fwd)
Date: Fri, 22 Apr 2011 10:31:47 +0200
Message-ID: <20110422103147.24c79768@endymion.delvare>
References: <alpine.DEB.2.01.1104211758220.18728@trent.utfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.01.1104211758220.18728-yMVncJ7Z0T9hhup4ARC/jw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Kujau <lists-AanptEQQ3TL9uQeqpI+JUg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Christian,

Redirecting to the right mailing list, as 1* this is an i2c issue and
2* the therm_adt746x driver doesn't integrate into the standard
hwmon/libsensors interface anyway.

On Thu, 21 Apr 2011 17:59:50 -0700 (PDT), Christian Kujau wrote:
> Starting with 2.6.38+, I noticed the following messages during bootup:
> 
> i2c i2c-0: attach_adapter method is deprecated
> Please use another way to instantiate your i2c_client
> 
> adt746x seems to continue to work, though. This is on a PowerBook G4.
> 
> Is this something to be worried about?

This will be something to worry about if nobody fixes the code before
September 2011, when the deprecated methods get removed.

I think Ben is working on this. Ben, any progress? Did you manage to
convert the code? If not, is there anything I can do to help?

-- 
Jean Delvare
