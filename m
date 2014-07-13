From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2] i2c: stub: Add support for SMBus block commands
Date: Sun, 13 Jul 2014 09:21:27 +0200
Message-ID: <20140713092127.4bedfa18@endymion.delvare>
References: <1404742983-27303-1-git-send-email-linux@roeck-us.net>
	<20140708215453.0677d3ed@endymion.delvare>
	<53BC4F15.9030608@roeck-us.net>
	<20140712112019.618d8a03@endymion.delvare>
	<53C14ECD.7050105@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <53C14ECD.7050105@roeck-us.net>
Sender: linux-doc-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, Randy Dunlap <rdunlap@infradead.org>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Guenter,

On Sat, 12 Jul 2014 08:05:49 -0700, Guenter Roeck wrote:
> Any idea how we could inject errors ? Error path testing would be quite useful.

Good idea. This should probably be done with a sysfs attribute so that
it can be turned on and off as desired. Off by default, of course. Some
other subsystems already support error injection, you could check how
they are doing it, do that we do not diverge needlessly.

Do you think there is any value in failing with different error codes,
or just -EIO is enough?

Do you think it should fail all the time when error injection is
enabled, or is there a value in having only a certain % of commands
fail?

-- 
Jean Delvare
SUSE L3 Support
