From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v7 3/7] drivers/i2c: Add port structure to FSI algorithm
Date: Thu, 31 May 2018 07:16:00 +1000
Message-ID: <8aaa7fa9874bf140354964535ce5cf023012c3f4.camel@kernel.crashing.org>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
         <1527632665-25707-4-git-send-email-eajames@linux.vnet.ibm.com>
         <CAHp75Vd38BrJcULxoqj1mTKCEvMh9ZVYEvzCMAg2t9onZrSR6w@mail.gmail.com>
         <ae3de08c-6849-bb3a-7c6c-96309876d48e@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ae3de08c-6849-bb3a-7c6c-96309876d48e@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Edward A. James" <eajames@us.ibm.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, 2018-05-30 at 10:47 -0500, Eddie James wrote:
> > > +       if (!list_empty(&i2c->ports)) {
> > 
> > My gosh, this is done already in list_for_each*()
> 
> No, list_for_each_entry does NOT check if the list is empty or if the 
> first entry is NULL.

NULL is never valid for a list. It does however check for an empty list

It does it implicitely in the test part of the for () statement,
checking if the next pointer points back to the head.

Cheers,
Ben.
