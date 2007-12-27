From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 0/5] Version 17, series to add device tree naming to i2c
Date: Thu, 27 Dec 2007 11:47:10 -0500
Message-ID: <9e4733910712270847j35778e43i66fda3eca9dc125@mail.gmail.com>
References: <20071220044136.20091.70984.stgit@terra.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753253AbXL0QrW@vger.kernel.org>
In-Reply-To: <20071220044136.20091.70984.stgit@terra.home>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 12/19/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> Another rework of the i2c for powerpc device tree patch. This version implements standard alias naming only on the powerpc platform and only for the device tree names. The old naming mechanism of i2c_client.name,driver_name is left in place and not changed for non-powerpc platforms. This patch is fully capable of dynamically loading the i2c modules. You can modprobe in the i2c-mpc driver and the i2c modules described in the device tree will be automatically loaded. Modules also work if compiled in.


Are there any further objections to this patch? Can it all go in
through the powerpc trees or do the i2c people want to send it on?

-- 
Jon Smirl
jonsmirl@gmail.com
