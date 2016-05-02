From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Mon, 2 May 2016 15:40:45 +0300
Message-ID: <20160502124045.GA1717@lahna.fi.intel.com>
References: <1461839010-110231-1-git-send-email-mika.westerberg@linux.intel.com>
 <577f885f-b54d-cf55-b1a3-0b04358271d8@kernel.org>
 <20160429085615.GK32610@lahna.fi.intel.com>
 <CALCETrWe+juuxO9bhv-=V6j9z=a2N+4BWO8Uaa_zMxYNQEA2Lg@mail.gmail.com>
 <20160502101218.GM32610@lahna.fi.intel.com>
 <CAJZ5v0gjB5_2Oer_Oq1B-J9Sx9wBw89mcdhfd=7V2gTmQoaLKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4068 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231AbcEBMlE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 2 May 2016 08:41:04 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gjB5_2Oer_Oq1B-J9Sx9wBw89mcdhfd=7V2gTmQoaLKQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Mario Limonciello <mario_limonciello@dell.com>

On Mon, May 02, 2016 at 01:42:41PM +0200, Rafael J. Wysocki wrote:
> > So what we are currently doing (preventing the driver from loading) is
> > the right thing to do according the above.
> 
> In general, that is the right thing to do.  That's why we do it as a rule. :-)
> 
> However, in this particular case we actually know that the opregion
> declaration is bogus at least on some systems.  So, this is a
> workaround for a known defect in some systems' ACPI tables.

Fair enough :)
