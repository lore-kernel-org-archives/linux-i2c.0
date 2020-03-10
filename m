From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] HID: mcp2221: add usb to i2c-smbus host bridge
Date: Tue, 10 Mar 2020 12:42:15 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.2003101241580.19500@cbobk.fhfr.pm>
References: <1580185137-11255-1-git-send-email-gupt21@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgCJLmY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 10 Mar 2020 07:42:24 -0400
In-Reply-To: <1580185137-11255-1-git-send-email-gupt21@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rishi Gupta <gupt21@gmail.com>
Cc: benjamin.tissoires@redhat.com, wsa+renesas@sang-engineering.com, gregkh@linuxfoundation.org, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 28 Jan 2020, Rishi Gupta wrote:

> MCP2221 is a USB HID to I2C/SMbus host bridge device. This
> commit implements i2c and smbus host adapter support. 7-bit
> address and i2c multi-message transaction is also supported.

Applied; sorry this took me a bit longer to review.

-- 
Jiri Kosina
SUSE Labs
