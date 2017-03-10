From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PULL REQUEST] i2c for 4.11
Date: Fri, 10 Mar 2017 10:12:44 -0800
Message-ID: <CA+55aFwjUWLFBwyS9iNKA=43tX5Ki+Xu7L_tKMKEa7buVnscBA@mail.gmail.com>
References: <20170310123308.4suuobaz2q372tod@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:33732 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933025AbdCJSMq (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 10 Mar 2017 13:12:46 -0500
In-Reply-To: <20170310123308.4suuobaz2q372tod@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Mar 10, 2017 at 4:33 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
> here are some driver bugfixes from I2C. Unusual this time are the two
> reverts. One because I accidently picked a patch from the list which I
> should have pulled from my co-maintainer instead ("missing
> of_node_put"). And one which I wrongly assumed to be an easy fix but it
> turned out already that it needs more iterations ("copy device
> properties").

That first revert looks *entirely* pointless.

You added an extra revert, only to pull in the *exact* same patch. WTF?

Even if you wanted to pull that just to sync with somebody elses tree,
why do the revert? It would have merged fine. You can literally see in
the patches that the files had the exact same content, because the
"index" line ends up being the git ID of the blob.

So all I see is "completely and utterly unnecessary mess in the last 24 hours"

Please stop this kind of stupidity. Now I have that unnecessary revert
with a misleading commit log in my tree, in addition to that stupid
merge that has no explanation and just reinstates the exact same thing
you reverted.

And talking about that merge I will repeat this one more time: merges
are commits too. You had damn well add explanations for what a merge
merges and why it is done.

Because this doesn't explain anything:

    Merge branch 'i2c-mux/for-current' of
https://github.com/peda-r/i2c-mux into i2c/for-current

So either look at my merge messages and try to emulate that "what does
this merge do" model, or just don't do merges.

If you cannot explain a reason for a merge or be bothered to try to
write a commit message, you shouldn't be doing that merge. It really
is that simple.

Particularly don't do merges when they turn a single commit into
*four* commit (original, revert, merge, and alternate) and have bad
explanations for half of those.

So what you could have done is:

 - don't do the pull at all

 - if you want to do the pull to sync up or something, don't do the
revert, but instead make the merge message talk about *why* that merge
was done.

Since the *only* possible reason for that pull seems to have been to
make some git history match up, it damn well matters what the git
history is, and these commits should make sense. As it is, the history
just looks messy with bogus explanations.

                        Linus
