From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] i2c: Add message transfer tracepoints for I2C and SMBUS
Date: Fri, 13 Dec 2013 17:53:50 +0100
Message-ID: <20131213175350.0c4a95d5@endymion.delvare>
References: <20131213163349.4bc686c0@endymion.delvare>
	<20131213142627.4014.42860.stgit@warthog.procyon.org.uk>
	<3708.1386950736@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3708.1386950736@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-i2c@vger.kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, Wolfram Sang <wolfram@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On Fri, 13 Dec 2013 16:05:36 +0000, David Howells wrote:
> Jean Delvare <khali@linux-fr.org> wrote:
> 
> > One significant difference between both implementations is that the old
> > one logs before the actual transfer, while yours logs afterward. While I
> > understand this allows you to log the result of the transfer, this also
> > means you'll miss the log if the actual transaction locks the system
> > (we've seen this before.) Something to think about...
> 
> I could split each into three messages:
> 
> 	- Write request (has params & data buffer)
> 	- Read request (has params but no data buffer)
> 	- Read reply (has data buffer only)
> 
> It will make the transfer functions more complex, though, and will mean that,
> for i2c, you won't get all the replies to the messages in a batch in with the
> requests.  I can also label the messages with the index number.  Mostly I
> suspect this won't be a problem.

Fine with me, we can leave it as is and revisit if it ever is a
problem in practice.

-- 
Jean Delvare
