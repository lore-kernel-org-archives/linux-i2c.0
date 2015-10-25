From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 1/2] acpi: add acpi_preset_companion() stub
Date: Sun, 25 Oct 2015 16:00:30 +0100
Message-ID: <10563412.ltsSVLcQgX@vostro.rjw.lan>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com> <1445628427-29244-2-git-send-email-dustin@cumulusnetworks.com> <20151024164123.GA1583@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54249 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751993AbbJYObh (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 25 Oct 2015 10:31:37 -0400
In-Reply-To: <20151024164123.GA1583@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Dustin Byford <dustin@cumulusnetworks.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Puustinen, Ismo" <ismo.puustinen@intel.com>

On Saturday, October 24, 2015 06:41:24 PM Wolfram Sang wrote:
> 
> --wac7ysb48OaltWcw
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Fri, Oct 23, 2015 at 12:27:06PM -0700, Dustin Byford wrote:
> > Add a stub for acpi_preset_companion().  Fixes build failures when
> > acpi_preset_companion() is used and CONFIG_ACPI is not set.
> >=20
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>
> 
> Waiting for Rafael's ack here...

Sent in response to the patch message.

Thanks,
Rafael
