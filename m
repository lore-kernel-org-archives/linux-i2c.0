From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Mon, 2 May 2016 18:50:21 +0300
Message-ID: <20160502155021.GB1717@lahna.fi.intel.com>
References: <1461839010-110231-1-git-send-email-mika.westerberg@linux.intel.com>
 <577f885f-b54d-cf55-b1a3-0b04358271d8@kernel.org>
 <20160429085615.GK32610@lahna.fi.intel.com>
 <CALCETrWe+juuxO9bhv-=V6j9z=a2N+4BWO8Uaa_zMxYNQEA2Lg@mail.gmail.com>
 <20160502101218.GM32610@lahna.fi.intel.com>
 <CALCETrWur5HhsHsBAH2y85-ZPbRdkZSL_XyT-kNBrzTMCtMdLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:16509 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754022AbcEBPu0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 2 May 2016 11:50:26 -0400
Content-Disposition: inline
In-Reply-To: <CALCETrWur5HhsHsBAH2y85-ZPbRdkZSL_XyT-kNBrzTMCtMdLQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Mario Limonciello <mario_limonciello@dell.com>

On Mon, May 02, 2016 at 08:29:42AM -0700, Andy Lutomirski wrote:
> On Mon, May 2, 2016 at 3:12 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Fri, Apr 29, 2016 at 06:13:52PM -0700, Andy Lutomirski wrote:
> >> A question, though: there's nothing that keeps i801_access from being
> >> called in between consecutive ACPI accesses.  Could this confuse the
> >> ASL code?  Would it be helpful if i801_access were to save away the
> >> old register state and restore it when it's done in the event that an
> >> opregion access has been seen so that the ASL-configured state doesn't
> >> get stomped on?
> >
> > Looking at those ASL methods of Lenovo Yoga 900 for example they seem to
> > initialize the hardware, do the transaction and cleanup in one go.
> > That's also what the i2c-i801.c driver is doing as far as I can say. So
> > in that sense they should not mess with each other.
> >
> 
> Is your locking actually sufficient to get that right?  You're taking
> acpi_lock, which is private to the driver, so you're only holding it
> during actual opregion access AFAICT.  That means that, if one thread
> is in the ACPI interpreter in one of these blocks and another thread
> is in the driver, they could still interleave their accesses.  Am I
> missing something?

No, you are right.

> > Of course this all breaks if the ASL code expects the state to survive
> > between transactions.
> >
> >> Also, what happens if i801_access happens while the i801 master is
> >> busy with an ASL-initiated transaction?  Will it wait for the
> >> transaction to finish?
> >
> > Yes, it should since ->acpi_lock is taken by i801_acpi_io_handler().
> 
> But i801_acpi_io_handler has no concept of a transaction AFAICT.

Indeed it only handles access one-by-one not by transaction. So if the
ASL code is in middle of a transaction and i2c-i801.c starts one as well
it will mess the registers.

Back to drawing board :-/
