Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D61C4A24;
	Mon,  2 Feb 2026 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770038537; cv=none; b=E0VDdWtOS2jlIPcAZtCeJ5fPedkd6MKf2Hzp4ystb050SwwHyhbs3iS8R8loEmGL6/3WlSq14DYaMmMGlAZy48yIDlJASqOUdW72P6UrclDNqHk5meKaX/oRyhgyNyw00cUvpIFT3d5ewf5SjSDuxHgYqnlAt/QFzby4TfZNEfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770038537; c=relaxed/simple;
	bh=/lHLusT8b/PQEBnxTk/bzggRgt/OBGViLMw2gcjqSpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAnZife1nGXifnvT1OnebBCfjneOInpvHIELPLAktIuGjYwC4PGyB9Vn9ZjK+0uo3C3nLQb2dgPtQwDvZUODFL1Ez9bZKxRlKp9TPsFYT7vuZ4RL0jpMv2QCdFbtwUtmX45sVAu5e7GWM1MPG5vRM1I/L3RSBXeBtaRzPZG9T4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F4pbd56h; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F4pbd56h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=IKjh/dGfqXvJnPMfjfG2oA+Fh/6tItlZ/M9uol9KUZo=; b=F4
	pbd56hm1nF3JsEosjN492dwuOR/KsYByigEMqbqClTnfCZxukQnMp7Vro/WIkMVyw//cNUf9UxzTd
	qCotNG+K6zIT4i22ybfFtYxxQUPpuTDQQiy8F1mdFyunXdTOznISJ4Y3ra2VUSLEUWoHy0fY5kZmo
	5yUG3BrLeV2KZ7Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vmtsE-005pJo-W9; Mon, 02 Feb 2026 14:21:51 +0100
Date: Mon, 2 Feb 2026 14:21:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/6] i2c: xiic: skip input clock setup on non-OF
 systems
Message-ID: <8be34da2-bf0e-47a0-bf91-3329ed0ec8ab@lunn.ch>
References: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
 <20260129-i2c-xiic-v7-1-727e434897ef@nexthop.ai>
 <ab9dc191-59c1-40a9-bbf1-e6c082af128a@lunn.ch>
 <2428D892-89F9-4013-9681-AD9BD76B0874@nexthop.ai>
 <aX3VqGlIUGCvMY5p@smile.fi.intel.com>
 <CAGYn4vxRbPVFvzm1b_mk2KvnRcJSO0Ewmx1tCTEALaZAu+ZQJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGYn4vxRbPVFvzm1b_mk2KvnRcJSO0Ewmx1tCTEALaZAu+ZQJQ@mail.gmail.com>

On Sat, Jan 31, 2026 at 08:30:40PM -0500, Abdurrahman Hussain wrote:
> On Sat Jan 31, 2026 at 10:12 AM UTC, Andy Shevchenko wrote:
> > On Thu, Jan 29, 2026 at 03:29:45PM -0800, Abdurrahman Hussain wrote:
> >> > On Jan 29, 2026, at 2:43 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> >> > On Thu, Jan 29, 2026 at 09:43:13PM +0000, Abdurrahman Hussain via B4 Relay wrote:
> >
> >> >> The xiic driver supports operation without explicit clock configuration
> >> >> when clocks cannot be specified via firmware, such as on ACPI-based
> >> >> systems.
> >> >
> >> > Are you saying it is technically impossible to specify a clock in
> >> > ACPI?
> >> >
> >> > Maybe a more accurate would be:
> >> >
> >> > The xiic driver supports operation without explicit clock
> >> > configuration when the clocks are not specified via firmware, such as
> >> > when the ACPI tables are missing the description of the clocks.
> >>
> >> Actually, ACPI (since 6.5) added a ClockInput() macro that can be added to
> >> _CRS of a device node. The ACPI subsystem in kernel could parse these and
> >> convert into proper clocks integrated with the CCF. But, AFAIK, this idea was
> >> rejected in the past.
> >
> > Rejected by which side? CCF?
> > Because specification still has that.
> 
> I think the argument was that on ACPI based systems clocks are "owned"
> by AML and there could be syncronizations issuebetween AML and the OS.
> 
> See https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1712165.html

Doesn't that just mean there needs to be a call into AML to request it
take an action on a clock? Otherwise, why even have ClockInput()? This
link is to quite an old thread, 2018, where as ClockInput seems to be
pretty new.

The fact ClockInput() exists, means at some point somebody will
implement it. Once it has been implemented, somebody might need to use
it with xiic? Because it is mandatory in DT, and there is no ACPI
binding document for xiic, they could make it mandatory in ACPI as
well. And then your device breaks.

By putting in the commit message something like:

Currently Linux does not implement ACPI ClockInput to describe clock
resources, unlike DT. However the xiic driver is happy if something
magically enables the clock before the driver probes, and does not
turn it off again. The clock should always be considered optional for
ACPI.

That should act has a hint to future developers hacking on xiic not to
make it mandatory.

     Andrew


