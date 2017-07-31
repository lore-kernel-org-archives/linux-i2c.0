From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v1] i2c: aspeed: fixed potential null pointer dereference
Date: Mon, 31 Jul 2017 11:20:29 -0700
Message-ID: <CAFd5g44UjOfGwpCdCTQ7-0rPTXoWLvDcYAbekQ-JMtNsYHZneQ@mail.gmail.com>
References: <20170729010012.5032-1-brendanhiggins@google.com> <CACPK8XdT5yxKFj75JCuXZ+3GT1Q6x0EYADmFdu6we6SHwTMnLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACPK8XdT5yxKFj75JCuXZ+3GT1Q6x0EYADmFdu6we6SHwTMnLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>
Cc: Wolfram Sang <wsa@the-dreams.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Patrick Venture <venture@google.com>, linux-i2c@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 31, 2017 at 2:27 AM, Joel Stanley <joel@jms.id.au> wrote:
> On Sat, Jul 29, 2017 at 10:30 AM, Brendan Higgins
> <brendanhiggins@google.com> wrote:
>> Before I skipped null checks when the master is in the STOP state; this
>> fixes that.
>>
>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>
> Acked-by: Joel Stanley <joel@jms.id.au>
>
> Out of interest, was this found by code review, or did you hit this in testing?

I am pretty sure we hit it in testing. Unfortunately, we had trouble reproducing
it, but we did see a null pointer dereference.

>
> Cheers,
>
> Joel
