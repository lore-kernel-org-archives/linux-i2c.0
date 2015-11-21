From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] i2c: xlr: add support for Sigma Designs controller variant
Date: Sat, 21 Nov 2015 12:02:48 +0000
Message-ID: <yw1x8u5rd0gn.fsf@unicorn.mansr.com>
References: <1446429818-24155-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:57524 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbbKUMCv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 21 Nov 2015 07:02:51 -0500
In-Reply-To: <1446429818-24155-1-git-send-email-mans@mansr.com> (Mans
	Rullgard's message of "Mon, 2 Nov 2015 02:03:36 +0000")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Mans Rullgard <mans@mansr.com> writes:

> Sigma Designs chips use a variant of this controller with the followi=
ng
> differences:
>
> - The BUSY bit in the STATUS register is inverted
> - Bit 8 of the CONFIG register must be set
> - The controller can generate interrupts
>
> This patch adds support for the first two of these.  It also calculat=
es
> and sets the correct clock divisor if a clk is provided.  The bus
> frequency is optionally speficied in the device tree node.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  drivers/i2c/busses/Kconfig   |  6 ++--
>  drivers/i2c/busses/i2c-xlr.c | 81 ++++++++++++++++++++++++++++++++++=
+++++++---
>  2 files changed, 80 insertions(+), 7 deletions(-)

Any comments on these patches?

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
