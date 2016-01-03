From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
Date: Sun, 03 Jan 2016 01:54:31 +0100
Message-ID: <4133541.hlxbdmvYbG@vostro.rjw.lan>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56473 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751047AbcACAXz (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 2 Jan 2016 19:23:55 -0500
In-Reply-To: <1449782357-22982-1-git-send-email-lho@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Loc Ho <lho@apm.com>
Cc: wsa@the-dreams.de, Ken.Xue@amd.com, Jeff.Wu@amd.com, mika.westerberg@linux.intel.com, lenb@kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, patches@apm.com

On Thursday, December 10, 2015 02:19:15 PM Loc Ho wrote:
> Add APM X-Gene ACPI I2C device support. These patches follow
> the same implementation as AMD I2C driver - changes in ACPI APD
> and Designware I2C drivers.
> 
> v2:
> * Spilt the acpi_apd change with defines for AMD and X-Gene I2C's
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
> Loc Ho (2):
>   acpi:apd: Add APM X-Gene ACPI I2C device support
>   i2c:dw: Add APM X-Gene ACPI I2C device support

Both patches applied, thanks!
