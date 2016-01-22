From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v5 3/3] i2c-piix4: Add adapter port name support for
 SB800 chipset
Date: Fri, 22 Jan 2016 14:20:54 +0100
Message-ID: <20160122142054.38d2d06f@endymion.delvare>
References: <1447960429-19256-1-git-send-email-fetzer.ch@gmail.com>
	<1447960429-19256-4-git-send-email-fetzer.ch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49816 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753623AbcAVNU5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 22 Jan 2016 08:20:57 -0500
In-Reply-To: <1447960429-19256-4-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Fetzer <fetzer.ch@gmail.com>
Cc: linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, galandilias@gmail.com

On Thu, 19 Nov 2015 20:13:49 +0100, Christian Fetzer wrote:
> This patch adds support for port names for the SB800 chipset.
> Since the chipset supports a multiplexed main SMBus controller, adding
> the channel name to the adapter name is necessary to differentiate the
> ports better (for example in sensors output).
> (...)

Note that I'm not too happy with this change. I understand the need for
unique I2C bus names, however changing names for legacy devices which
have a single bus is bad. The name can be used in sensors.conf or in
scripts to uniquely reference a specific I2C bus, and changing it will
break that.

So I'd rather only change the names for the mux'd SB800 ports where
this is needed, and leave the rest untouched.

Also I don't much like "SDA0"... in bus names. SDA0 standard for
"serial data 0" is the name of one of the pins for SMBus channel 0. The
other one is SCL0 ("serial clock 0".) There's no reason to include a
pin name in the I2C adapter name string, just the channel number
matters.

I'll submit a patch later today that implements things the way I would
like, and you can comment on it.
-- 
Jean Delvare
SUSE L3 Support
