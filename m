From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [MinnowBoard] Linux x86 I2C device probing with ACPI
Date: Mon, 02 Nov 2015 12:11:18 +0200
Message-ID: <1446459078.6332.75.camel@linux.intel.com>
References: <1445455164-5566-1-git-send-email-christophe-h.ricard@st.com>
	 <20151022081806.GJ1526@lahna.fi.intel.com> <5636862C.40000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37250 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226AbbKBKLT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 2 Nov 2015 05:11:19 -0500
In-Reply-To: <5636862C.40000@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christophe Ricard <christophe.ricard@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org

On Sun, 2015-11-01 at 22:37 +0100, Christophe Ricard wrote:
> Hi Mika,
>=20
> Sorry for the delay.
> After forcing _STA method to return 0xF

You mean you able to fix firmware? Great!

>  and moving NFC1 node into=20
> Scope(I2C7) node the probing went through.

This one is not required anymore since

commit 166c2ba398640278ae6037be4aa5562c03cf3d24
Author: Mika Westerberg <mika.westerberg@linux.intel.com>
Date:=C2=A0=C2=A0=C2=A0Wed Oct 7 13:18:44 2015 +0300

=C2=A0=C2=A0=C2=A0=C2=A0i2c / ACPI: Rework I2C device scanning

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
