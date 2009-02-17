From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Bug#513894: Oops: f3 with i2c-tiny-usbHello,
Date: Tue, 17 Feb 2009 11:24:15 +0100
Message-ID: <20090217112415.6cbb6fc2@hyperion.delvare>
References: <20090209181043.GB19801@deprecation.cyrius.com>
	<200902092029.05036.till@harbaum.org>
	<200902170435.53010.tom-koch@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200902170435.53010.tom-koch-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Koch <tom-koch-Mmb7MZpHnFY@public.gmane.org>
Cc: Till Harbaum <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>, Martin Michlmayr <tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 513894-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 17 Feb 2009 04:35:52 +0100, Thomas Koch wrote:
> What I also noticed is when I do an i2cdetect the bus type of the interface is 
> shown as dummy. Normaly the type is i2c.

"i2cdetect -l" queries the bus functionality to find out whether it can
do raw I2C or only SMBus. If it returns "dummy" this means that the
functionality request itself failed (which would probably be confirmed
by "i2cdetect -F"), which isn't necessarily surprising if the
i2c-tiny-usb driver is crashed.

-- 
Jean Delvare
