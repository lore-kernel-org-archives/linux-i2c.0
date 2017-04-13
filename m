From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v6] platform/x86: Add Intel Cherry Trail ACPI INT33FE
 device driver
Date: Thu, 13 Apr 2017 12:12:12 -0700
Message-ID: <20170413191212.GB9783@fury>
References: <20170406072436.12898-1-hdegoede@redhat.com>
 <1491476636.24567.25.camel@linux.intel.com>
 <8b6df86e-06eb-5be8-ee8c-9af980691fa5@redhat.com>
 <20170406224815.GA13110@fury>
 <66d4f7cc-4f4b-f912-ca8a-50fd248cc405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <66d4f7cc-4f4b-f912-ca8a-50fd248cc405@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, platform-driver-x86@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 07, 2017 at 08:49:55AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 07-04-17 00:48, Darren Hart wrote:
> > On Thu, Apr 06, 2017 at 02:17:11PM +0200, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 06-04-17 13:03, Andy Shevchenko wrote:
...
> > > > In this case this so called "pseudo" device is not so pseudo, but
> > > > "master".
> > > 
> > > I think this is really some Windows weirdness, if I configure the BIOS
> > > to boot "Android" the ACPI INT33FE device goes away and instead I
> > > get 3 separate ACPI devices for the 3 chips.
> > 
> > So if this is this case, what is the value in supporting "windows weirdness" if
> > the end user can select "Android" and be presented with 3 separate devices?
> 
> Multiple reasons:
> 
> 1) Multi-boot with windows without needing to toggle a BIOS option all the time
> 2) Many of these devices only ship with windows, the Android option is there
> from the BIOS template code they used, but is untested, so this may give us
> the 3 separate devices but at the same time break other stuff
> 3) On some devices the BIOS tries to autodetect the OS, overriding the BIOS option
> 4) On some devices, including the one I'm developing on, but I can "fix" this with
> a BIOS downgrade, this option has been locked to avoid 2.
> 5) Users really should not need to touch BIOS settings ever

Agreed on all points.

I'm happy to pull this in. I need an immutable i2c branch with the dependencies
to do so.

-- 
Darren Hart
VMware Open Source Technology Center
