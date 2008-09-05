From: Jean Delvare <khali@linux-fr.org>
Subject: Re: qestion about I2C_CLASS_HWMON flag
Date: Fri, 5 Sep 2008 15:11:57 +0200
Message-ID: <20080905151157.21b7f8ce@hyperion.delvare>
References: <38b2ab8a0809040043g7f944872l47f84c53bb213829@mail.gmail.com>
	<38b2ab8a0809040105j7ae3aca8xd334a4d203d9415b@mail.gmail.com>
	<20080904103707.557ac764@hyperion.delvare>
	<38b2ab8a0809040149u2bc0342h5c32b87f9277322f@mail.gmail.com>
	<20080904120855.7e7b9720@hyperion.delvare>
	<38b2ab8a0809050157yfb21b08v23ae368d3337c1ca@mail.gmail.com>
	<20080905112056.44b7b910@hyperion.delvare>
	<38b2ab8a0809050544l1914530clec53494e12c77ff5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753884AbYIENMU@vger.kernel.org>
In-Reply-To: <38b2ab8a0809050544l1914530clec53494e12c77ff5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 5 Sep 2008 14:44:30 +0200, Francis Moreau wrote:
> On Fri, Sep 5, 2008 at 11:20 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > Nothing prevents you from setting the class flags based on
> > platform-specific information if you have a need for that.
> 
> Just to be sure, do you mean by hacking the adapter source code ?

It's not about hacking, it can be done cleanly. Just have the adapter
driver code check for information in the platform data, and if class
information is provided, use that instead of the default value. Or if
all users will provide the information, don't even have a default in
the driver. Again, the class flags are a (needed) mechanism, the policy
is left for driver authors and platform maintainers to establish.

> > That being said, in cases where you have that level of information
> > about which devices are present on the I2C bus,
> 
> Isn't the case for most of all embedded platforms ?

Indeed.

> > you probably want to
> > declare the I2C devices at the platform level, and not rely on probing
> > at all (so .class is 0).
> 
> do you mean by using I2C_BOARD_INFO ?

Exactly. Except on powerpc where they have a different mechanism, I
think.

-- 
Jean Delvare
