From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] i2c: i2c-scmi: add a MS HID
Date: Thu, 6 Apr 2017 11:03:09 +0300
Message-ID: <20170406080309.GP2957@lahna.fi.intel.com>
References: <1491322707-2991-1-git-send-email-vkrasnov@dev.rtsoft.ru>
 <20170405145932.3ef689d5@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170405145932.3ef689d5@endymion>
Sender: linux-acpi-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com, echerkasov@dev.rtsoft.ru, Michael.Brunner@kontron.com
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 05, 2017 at 02:59:32PM +0200, Jean Delvare wrote:
> On Tue,  4 Apr 2017 19:18:27 +0300, Viktor Krasnov wrote:
> > From: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
> > 
> > Description of the problem:
> >  - i2c-scmi driver contains only two identifiers "SMBUS01" and "SMBUSIBM";
> >  - the fist HID (SMBUS01) is clearly defined in "SMBus Control Method
> >    Interface Specification, version 1.0": "Each device must specify
> >    'SMBUS01' as its _HID and use a unique _UID value";
> >  - unfortunately, BIOS vendors (like AMI) seem to ignore this requirement
> >    and implement "SMB0001" HID instead of "SMBUS01";
> >  - I speculate that they do this because only "SMB0001" is hard coded in
> >    Windows SMBus driver produced by Microsoft.
> > 
> > This leads to following situation:
> >  - SMBus works out of box in Windows but not in Linux;
> >  - board vendors are forced to add correct "SMBUS01" HID to BIOS to make
> >    SMBus work in Linux. Moreover the same board vendors complain that
> >    tools (3-rd party ASL compiler) do not like the "SMBUS01" identifier
> >    and produce errors.  So they need to constantly patch the compiler for
> >    each new version of BIOS.
> > 
> > As it is very unlikely that BIOS vendors implement a correct HID in
> > future, I would propose to consider whether it is possible to work around
> > the problem by adding MS HID to the Linux i2c-scmi driver.
> > 
> > v2: move the definition of the new HID to the driver itself.
> > 
> > Signed-off-by: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
> > Signed-off-by: Michael Brunner <Michael.Brunner@kontron.com>
> > Acked-by: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
> 
> Reviewed-by: Jean Delvare <jdelvare@suse.de>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
