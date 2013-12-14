From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] i2c: Add message transfer tracepoints for I2C and SMBUS
Date: Sat, 14 Dec 2013 00:16:27 +0000
Message-ID: <11338.1386980187@warthog.procyon.org.uk>
References: <20131213131353.17d49ac4@gandalf.local.home> <20131213175350.0c4a95d5@endymion.delvare> <20131213163349.4bc686c0@endymion.delvare> <20131213142627.4014.42860.stgit@warthog.procyon.org.uk> <3708.1386950736@warthog.procyon.org.uk> <18214.1386955613@warthog.procyon.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131213131353.17d49ac4@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: dhowells@redhat.com, Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wolfram@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:

> Now that you have two tracepoints that are identical, you can use
> DECLARE_EVENT_CLASS() and DEFINE_EVENT_FN(). That is:

They're not identical.  i2c_write() has a data buffer that i2c_read() does
not.

David
