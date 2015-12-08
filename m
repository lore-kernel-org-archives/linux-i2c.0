From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c:dw: Add APM X-Gene ACPI I2C device support
Date: Tue, 8 Dec 2015 13:36:02 +0200
Message-ID: <20151208113602.GL1766@lahna.fi.intel.com>
References: <1449533774-22672-1-git-send-email-lho@apm.com>
 <1449533774-22672-3-git-send-email-lho@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64091 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932345AbbLHLiO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 8 Dec 2015 06:38:14 -0500
Content-Disposition: inline
In-Reply-To: <1449533774-22672-3-git-send-email-lho@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Loc Ho <lho@apm.com>
Cc: wsa@the-dreams.de, Ken.Xue@amd.com, Jeff.Wu@amd.com, rjw@rjwysocki.net, lenb@kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, patches@apm.com

On Mon, Dec 07, 2015 at 05:16:14PM -0700, Loc Ho wrote:
> Enable APM X-Gene ACPI I2C device support by adding the
> corresponding ACPI ID. The platform ACPI APD corresponding
> change is required to provide the proper clock frequency input.
> 
> Signed-off-by: Loc Ho <lho@apm.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
