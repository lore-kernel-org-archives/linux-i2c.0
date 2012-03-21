From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/2] i2c-tools: Clean up <linux/i2c-dev.h>
Date: Wed, 21 Mar 2012 10:11:11 +0100
Message-ID: <20120321101111.3e9202fc@endymion.delvare>
References: <20120315165344.5f8e060f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120315165344.5f8e060f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 15 Mar 2012 16:53:44 +0100, Jean Delvare wrote:
> For years now, project i2c-tools has been carrying a modified copy of
> <linux/i2c-dev.h> for use by user-space applications
> accessing /dev/i2c-* device nodes. The modified copy includes parts of
> <linux/i2c.h> as well as i2c_smbus_*() inline functions mimicking their
> kernel counterparts.
> 
> Why it was done that way, I'm not sure. Maybe to make things easier for
> application authors, or maybe just because nobody ever cared to clean
> it all up. But what I'm sure of is that the current situation is ugly
> and should be cleaned up. Kernel interfaces should be described by
> kernel header files, not random user-space tool projects.
> 
> So I have a plan to get rid of <linux/i2c-dev.h> in i2c-tools. This is
> the first step of a more ambitious plan to move the inline
> i2c_smbus_*() functions to a proper library - they are too large to be
> inline functions and recent versions of gcc complain about that.

I have added a page to the wiki, describing the problem and solution:
http://www.lm-sensors.org/wiki/I2CTools_4_Plan

-- 
Jean Delvare
