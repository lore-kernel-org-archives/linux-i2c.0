From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH v4 11/14] i2c-octeon: Rename driver to prepare for split
Date: Fri, 18 Mar 2016 10:11:10 -0700
Message-ID: <56EC36AE.9050603@caviumnetworks.com>
References: <cover.1458289385.git.jglauber@cavium.com> <e618ce0f8824d04311c5796cdb6688b55e6afa6f.1458289385.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0077.outbound.protection.outlook.com ([65.55.169.77]:65222
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752572AbcCRRLS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 18 Mar 2016 13:11:18 -0400
In-Reply-To: <e618ce0f8824d04311c5796cdb6688b55e6afa6f.1458289385.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

On 03/18/2016 01:46 AM, Jan Glauber wrote:
> This is just an intermediate commit in preparation of
> the driver split. The module rename in this commit
> will be reverted in the next patch, this is just done
> to make the series bisectible.
>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>   drivers/i2c/busses/Makefile          |    2 +-
>   drivers/i2c/busses/i2c-octeon-core.c | 1264 ++++++++++++++++++++++++++++++++++
>   drivers/i2c/busses/i2c-octeon.c      | 1264 ----------------------------------
>   3 files changed, 1265 insertions(+), 1265 deletions(-)
>   create mode 100644 drivers/i2c/busses/i2c-octeon-core.c
>   delete mode 100644 drivers/i2c/busses/i2c-octeon.c
>
Again, if we need another patch submission, use "git format-patch -M ..."
