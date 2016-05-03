From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Tue, 3 May 2016 11:53:07 +0300
Message-ID: <20160503085307.GD1717@lahna.fi.intel.com>
References: <1461839010-110231-1-git-send-email-mika.westerberg@linux.intel.com>
 <577f885f-b54d-cf55-b1a3-0b04358271d8@kernel.org>
 <20160429085615.GK32610@lahna.fi.intel.com>
 <CALCETrWe+juuxO9bhv-=V6j9z=a2N+4BWO8Uaa_zMxYNQEA2Lg@mail.gmail.com>
 <20160502101218.GM32610@lahna.fi.intel.com>
 <CALCETrWur5HhsHsBAH2y85-ZPbRdkZSL_XyT-kNBrzTMCtMdLQ@mail.gmail.com>
 <20160502155021.GB1717@lahna.fi.intel.com>
 <CAJZ5v0hS4O2eAUrAK4xC=s8OHtiTpj-bKjzry_GoKk2m5NktnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27312 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755787AbcECIxN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 3 May 2016 04:53:13 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hS4O2eAUrAK4xC=s8OHtiTpj-bKjzry_GoKk2m5NktnA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Mario Limonciello <mario_limonciello@dell.com>

On Mon, May 02, 2016 at 11:29:01PM +0200, Rafael J. Wysocki wrote:
> It doesn't look like trying to make it safe for both the driver and
> AML to use the same range of addresses is a realistic goal.  At least
> the benefit will not outweigh the resulting complexity if the opregion
> is actually never used by AML in practice.
> 
> So, why don't we have a flag that will make i801_access() return an
> error on every invocation when set (the callers of it should be able
> to cope with that or they are broken IMO) and why don't we set it when
> AML accesses the opregion first time?

Yeah, that occured to me also yesterday evening :)

> Yes, that will prevent the driver from actually working *when* AML
> turns out to use the opregion, but IMO that's a bit more friendly than
> preventing the driver from loading at all.

I agree. If nobody objects, I'm going to create v2 of the patch that
prevents further driver access if AML touches the OpRegion.
