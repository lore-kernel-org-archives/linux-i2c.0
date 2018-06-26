From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v10 4/7] i2c: fsi: Add abort and hardware reset procedures
Date: Tue, 26 Jun 2018 11:38:49 +0900
Message-ID: <20180626023849.op4rimmsnlv4rgwg@ninjato>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-5-git-send-email-eajames@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1528918579-27602-5-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 13, 2018 at 02:36:16PM -0500, Eddie James wrote:
> Add abort procedure for failed transfers. Add engine and bus reset
> procedures to recover from as many faults as possible.

I think this is a way too aggressive recovery. Your are doing the 9
pulse toggles basically on any error while this is only when the device
keeps SDA low and you want to recover from that. If SDA is not stuck
low, sending a STOP should do. Or do you have a known case where this is
not going to work?

Also, you implement the pulse toggling manually. Can't you just populate
{get|set}_{scl|sda} and use the generic routine we have in the core?
