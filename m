From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2] i2c: stub: Add support for SMBus block commands
Date: Thu, 17 Jul 2014 15:40:20 +0200
Message-ID: <20140717154020.650ad59c@endymion.delvare>
References: <1404742983-27303-1-git-send-email-linux@roeck-us.net>
	<20140717132135.GI2740@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140717132135.GI2740@katana>
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Randy Dunlap <rdunlap@infradead.org>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 17 Jul 2014 15:21:35 +0200, Wolfram Sang wrote:
> On Mon, Jul 07, 2014 at 07:23:03AM -0700, Guenter Roeck wrote:
> > SMBus block commands are different to I2C block commands since
> > the returned data is not normally accessible with byte or word
> > commands on other command offsets. Add linked list of 'block'
> > commands to support those commands.
> > 
> > Access mechanism is quite simple: Block commands must be written
> > before they can be read. The first write selects the block length.
> > Subsequent writes can be partial. Block read commands always return
> > the number of bytes selected with the first write.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2: Make new functionality only available on request via functionality
> >     module parameter
> >     Add more details about SMBus block mode support to documentation
> >     Use correct sizeof() variable in devm_kzalloc
> >     Use stub_find_block() only in SMBus block command itself.
> >     Store first word of block data in chip->words[].
> >     When writing block data and the written data is longer than
> >     the first write, bail out with debug message indicating the reason
> >     for the error.
> 
> Thanks for doing this and thanks to Jean for the thorough review.

You're welcome.

> The thing I miss is the documentation that SMBUS_BLOCK must explicitly
> be activated and the description how to do it. A comment in the driver,
> above STUB_FUNC_* defines might not hurt as well.

Good point.

> Also, I'd prefer to squash Jean's "increasing block length" patch into
> this one if both of you are fine with that?

Yes, I would be perfectly fine with that.

Guenter, can you please send an updated patch?

-- 
Jean Delvare
SUSE L3 Support
