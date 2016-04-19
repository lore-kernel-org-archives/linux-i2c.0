From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2] i2c: Add generic support passing secondary devices
 addresses
Date: Tue, 19 Apr 2016 09:27:39 -0700
Message-ID: <1461083259.8946.93.camel@linux.intel.com>
References: <1454254380-9246-1-git-send-email-jean-michel.hautbois@veo-labs.com>
	 <20160415080111.GD1714@lahna.fi.intel.com>
	 <1460992811.8946.22.camel@linux.intel.com> <5714FCBE.3060009@metafoo.de>
	 <20160419124028.GF1725@lahna.fi.intel.com> <57162C4E.9090904@metafoo.de>
	 <20160419131631.GG1725@lahna.fi.intel.com> <5716333D.1040106@metafoo.de>
	 <20160419144027.GH1725@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32896 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932482AbcDSQ1p (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 19 Apr 2016 12:27:45 -0400
In-Reply-To: <20160419144027.GH1725@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean-Michel Hautbois <jhautbois@gmail.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, wsa@the-dreams.de, laurent.pinchart@ideasonboard.com, Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>

On Tue, 2016-04-19 at 17:40 +0300, Mika Westerberg wrote:
> On Tue, Apr 19, 2016 at 03:31:41PM +0200, Lars-Peter Clausen wrote:
> > 
> > It adds a standard API for dealing with devices that have more than
> > one
> > address. It uses the normal way of specifying multiple (named)
> > address in DT.
> > 
> > reg = <0xa>, <0xb>, <0xc>;
> > reg-names = "main", "aux1", "aux2";
> > 
[...]

> Srinivas, do you think this works with the sensor stuff?
Yes, it will work.

Thanks,
Srinivas
