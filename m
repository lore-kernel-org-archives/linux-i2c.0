From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 12/19] i2c: mux: pca954x: make use of raw_spinlock
 variants
Date: Thu, 16 Mar 2017 20:38:06 +0100
Message-ID: <910fae4d-e5a7-f149-1daf-44e5487bf643@axentia.se>
References: <cover.1489015238.git.julia@ni.com>
 <a5015f6a7ecc2f84e9026c309ca2753c0cb3a1fa.1489015238.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0120.outbound.protection.outlook.com ([104.47.1.120]:54424
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752476AbdCPTyE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 16 Mar 2017 15:54:04 -0400
In-Reply-To: <a5015f6a7ecc2f84e9026c309ca2753c0cb3a1fa.1489015238.git.julia@ni.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Julia Cartwright <julia@ni.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-i2c@vger.kernel.org

On 2017-03-09 17:21, Julia Cartwright wrote:
> The pca954x i2c mux driver currently implements an irq_chip for handling
> interrupts; due to how irq_chip handling is done, it's necessary for the
> irq_chip methods to be invoked from hardirq context, even on a a
> real-time kernel.  Because the spinlock_t type becomes a "sleeping"
> spinlock w/ RT kernels, it is not suitable to be used with irq_chips.
> 
> A quick audit of the operations under the lock reveal that they do only
> minimal, bounded work, and are therefore safe to do under a raw spinlock.
> 
> Signed-off-by: Julia Cartwright <julia@ni.com>

Patch applied to the i2c-mux repo. Thanks!

Cheers,
peda
