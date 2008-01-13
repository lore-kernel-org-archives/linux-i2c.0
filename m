From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH] update module-init-tools to support the i2c subsystem
Date: Sun, 13 Jan 2008 10:14:14 -0500
Message-ID: <9e4733910801130714m1be16826jf240171972324d16@mail.gmail.com>
References: <9e4733910712171839h214e0bc3q179266c86e5987b1@mail.gmail.com>
	 <20080113152735.5dca46a1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753020AbYAMPO0@vger.kernel.org>
In-Reply-To: <20080113152735.5dca46a1@hyperion.delvare>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 1/13/08, Jean Delvare <khali@linux-fr.org> wrote:
> On Mon, 17 Dec 2007 21:39:37 -0500, Jon Smirl wrote:
> > Follow on to: "Series to add device tree naming to i2c"
> > Teach module-init-tools about the i2c subsystem.
>
> Can you please explain what this patch does and why it is needed?

It generates the entries needed for the user space module tools to
work with the aliases. For example modprobe/depmod. It is a standard
part of the kernel module system.

-- 
Jon Smirl
jonsmirl@gmail.com
