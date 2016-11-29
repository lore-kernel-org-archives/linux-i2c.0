From: "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
Date: Tue, 29 Nov 2016 12:22:34 -0600
Message-ID: <52c6e31e-9351-fa26-aefe-4f1415324adf@cavium.com>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
 <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
 <20161122120106.GB3993@katana> <20161122145539.GA7716@hardcore>
 <20161128142208.GA3916@katana> <20161129091928.GB29487@hardcore>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-cys01nam02on0068.outbound.protection.outlook.com ([104.47.37.68]:16736
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932739AbcK2SWm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 29 Nov 2016 13:22:42 -0500
In-Reply-To: <20161129091928.GB29487@hardcore>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>, Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>, David Daney <david.daney@cavium.com>

On 11/29/2016 03:19 AM, Jan Glauber wrote:
> 
> if possible we should at least revert commit 70121f7f3725. I should get
> access to an Octeon 71xx board tomorrow, but I'm afraid we'll miss the
> deadline for a well tested fix that works across all machines.
> 
I second Jan's advice. Please revert the commit and we'll have the
fix for the next release.
