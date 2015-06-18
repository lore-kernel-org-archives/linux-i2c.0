From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] driver/i2c/mux: Add register based mux i2c-mux-reg
Date: Thu, 18 Jun 2015 11:55:34 +0200
Message-ID: <1434621334.2385.69.camel@x220>
References: <1434475692-4611-1-git-send-email-yorksun@freescale.com>
	 <1434531244.2069.111.camel@x220> <55818BAB.5090605@nokia.com>
	 <1434556990.2400.16.camel@x220> <558275F1.5020100@nokia.com>
	 <1434614901.2385.27.camel@x220> <5582899B.9030307@nokia.com>
	 <1434619943.2385.59.camel@x220> <5582928D.4080706@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5582928D.4080706@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: York Sun <yorksun@freescale.com>, wsa@the-dreams.de, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Peter Korsgaard <peter.korsgaard@barco.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2015-06-18 at 11:42 +0200, Alexander Sverdlin wrote:
> Most of the usual drivers in the Kernel have this line.

Perhaps people copy and paste without really realizing what this macro
is supposed to be for. (I didn't know until a few days ago. I needed you
to confirm that I figured it out correctly.) Perhaps reviewers skip over
the boilerplate stuff. 

> Until now no animal was hurt with it.

Sure, no overhead and all that. No value too.

Thanks,


Paul Bolle
