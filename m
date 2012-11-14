From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH 1/2] i2c: Add possibility for user-defined (i2c-)devices
 for bus-drivers.
Date: Wed, 14 Nov 2012 03:47:46 +0100
Message-ID: <50A30652.1020208@ahsoftware.de>
References: <1352829968-4908-1-git-send-email-holler@ahsoftware.de> <20121113195533.6db71716@endymion.delvare> <50A2AC28.7050304@ahsoftware.de> <20121113220835.111a178a@endymion.delvare> <50A2BAA2.6090009@ahsoftware.de> <20121113224246.768bf734@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121113224246.768bf734@endymion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Till Harbaum <till@harbaum.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

Am 13.11.2012 22:42, schrieb Jean Delvare:

> Plus you don't address the main issues. Your syntax gives you no way to
> support two i2c-tiny-usb adapters with different chips at a specific
> address. The sysfs interface supports such a setup. Also instantiating
> the wrong devices is worse than instating a device that doesn't exist
> at all. So the use of i2c_new_probed_device() here will randomly help
> in a limited number of cases and randomly be problematic in others.
> Hard to justify...

As you seem to have a solution for multiple devices of the same type by
using sysfs, how to do you decide which one to use? You might be able to
probe just one, but my simple mind currently doesn't come up with a
solution which device one has to probe. Just because I'm curious... ;)

Regards,

Alexander
