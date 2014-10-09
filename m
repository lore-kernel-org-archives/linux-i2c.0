From: Mark Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: mpc: Report correct I2C error codes on Freescale MPC
 i2c bus driver
Date: Thu, 9 Oct 2014 09:46:37 -0400
Message-ID: <CAJjB1q+H3r9ZbN6O0wvpYajmZ+Y5Fk9ny2FRdO9e7tnfXrJmuw@mail.gmail.com>
References: <CAAVjN7fq-czDj5Ga_UC+fzqy3dcYY3bgU7Z5JUY829Va4rbeXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAVjN7fq-czDj5Ga_UC+fzqy3dcYY3bgU7Z5JUY829Va4rbeXQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

1. You are going to want to resend your patch using git-send-mail, you
used an email client that destroyed all formatting. gmail in
particular is good at breaking things so your patch cannot be applied
correctly.
2. You need to add a Signed-off-by line like other patches people submit.
3. You may want to consider CCing Wolfram the i2c subsystem maintainer
since there's no bus driver maintainer

see: https://www.kernel.org/doc/Documentation/SubmittingPatches
