From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] misc: Driver for Silicon Labs Si570 and compatibles
Date: Wed, 20 Apr 2011 18:44:30 +0200
Message-ID: <201104201844.30919.arnd@arndb.de>
References: <1303248968-5069-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1303248968-5069-1-git-send-email-guenter.roeck@ericsson.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Jonathan Cameron <kernel@jic23.retrosnub.co.uk>, Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 19 April 2011, Guenter Roeck wrote:
> This driver adds support for Si570, Si571, Si598, and Si599
> programmable XO/VCXO.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

This needs some more explanation of what the hardware is there for,
and why it's unlike everything else that we support in Linux.

We try not to have too many things in drivers/misc that are
one-off interfaces, so if the hardware is related to something
else, it should probably go into one subsystem.

My impression from readin the source code is that this is
simply a clock device that would be used in combination with
some other device in practice that consumes the clock.
If that is true, it should probably not have a user-visible
interface, but only an interface that can be used by other
kernel drivers.

	Arnd
