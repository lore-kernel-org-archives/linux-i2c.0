From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] i2c: Add generic support passing secondary devices
 addresses
Date: Tue, 19 Apr 2016 15:02:06 +0200
Message-ID: <57162C4E.9090904@metafoo.de>
References: <1454254380-9246-1-git-send-email-jean-michel.hautbois@veo-labs.com>
 <20160415080111.GD1714@lahna.fi.intel.com>
 <1460992811.8946.22.camel@linux.intel.com> <5714FCBE.3060009@metafoo.de>
 <20160419124028.GF1725@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:37880 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbcDSNCM (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Apr 2016 09:02:12 -0400
In-Reply-To: <20160419124028.GF1725@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jean-Michel Hautbois <jhautbois@gmail.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, wsa@the-dreams.de, laurent.pinchart@ideasonboard.com, Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>

On 04/19/2016 02:40 PM, Mika Westerberg wrote:
> On Mon, Apr 18, 2016 at 05:26:54PM +0200, Lars-Peter Clausen wrote:
>> A generic API by indexes wont work. The order between DT and ACPI will most
>> likely be different. I'd even assume that the order will be different with
>> ACPI for the same device on different platforms.
> 
> Yes, unfortunately that might be possible.
> 
>> If we want to support ACPI over the same interface drivers need to provide a
>> lookup table that maps a name to the index.
> 
> Indeed something like we already have with GPIOs. The lookup table could
> be filled from names in _DSD where it is available.

Does that mean you are OK with the patch as it is?
