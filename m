From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Mon, 2 May 2016 13:12:18 +0300
Message-ID: <20160502101218.GM32610@lahna.fi.intel.com>
References: <1461839010-110231-1-git-send-email-mika.westerberg@linux.intel.com>
 <577f885f-b54d-cf55-b1a3-0b04358271d8@kernel.org>
 <20160429085615.GK32610@lahna.fi.intel.com>
 <CALCETrWe+juuxO9bhv-=V6j9z=a2N+4BWO8Uaa_zMxYNQEA2Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrWe+juuxO9bhv-=V6j9z=a2N+4BWO8Uaa_zMxYNQEA2Lg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Mario Limonciello <mario_limonciello@dell.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 29, 2016 at 06:13:52PM -0700, Andy Lutomirski wrote:
> A question, though: there's nothing that keeps i801_access from being
> called in between consecutive ACPI accesses.  Could this confuse the
> ASL code?  Would it be helpful if i801_access were to save away the
> old register state and restore it when it's done in the event that an
> opregion access has been seen so that the ASL-configured state doesn't
> get stomped on?

Looking at those ASL methods of Lenovo Yoga 900 for example they seem to
initialize the hardware, do the transaction and cleanup in one go.
That's also what the i2c-i801.c driver is doing as far as I can say. So
in that sense they should not mess with each other.

Of course this all breaks if the ASL code expects the state to survive
between transactions.

> Also, what happens if i801_access happens while the i801 master is
> busy with an ASL-initiated transaction?  Will it wait for the
> transaction to finish?

Yes, it should since ->acpi_lock is taken by i801_acpi_io_handler().

> If this is a problem, an alternative approach might be to virtualize
> the registers as seen by ACPI and to only load them into the real
> registers when a transaction starts.
> 
> Also, what happens if the opregion is declared globally instead of in
> the scope of the ACPI companion?  Does that happen?  If so, it might
> make sense to deny loading the driver unless in lax mode.

I don't know if that happens but it is certainly possible.

Actually reading ACPI 6.1 spec again, chapter 5.5.2.4.3 says this:

  If a platform uses a PCI BAR Target operation region, an ACPI OS will
  not load a native device driver for the associated PCI function. For
  example, if any of the BARs in a PCI function are associated with a PCI
  BAR Target operation region, then the OS will assume that the PCI
  function is to be entirely under the control of the ACPI system
  firmware. No driver will be loaded.

So what we are currently doing (preventing the driver from loading) is
the right thing to do according the above. Maybe we can change that
warning into debug/info message instead?
