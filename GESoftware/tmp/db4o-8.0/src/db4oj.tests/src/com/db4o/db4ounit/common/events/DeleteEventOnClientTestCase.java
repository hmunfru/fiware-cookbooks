/* This file is part of the db4o object database http://www.db4o.com

Copyright (C) 2004 - 2011  Versant Corporation http://www.versant.com

db4o is free software; you can redistribute it and/or modify it under
the terms of version 3 of the GNU General Public License as published
by the Free Software Foundation.

db4o is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

You should have received a copy of the GNU General Public License along
with this program.  If not, see http://www.gnu.org/licenses/. */
package com.db4o.db4ounit.common.events;

import com.db4o.events.*;

import db4ounit.*;
import db4ounit.extensions.fixtures.*;

public class DeleteEventOnClientTestCase extends EventsTestCaseBase implements OptOutSolo {
	public static void main(String[] args) {
		new DeleteEventOnClientTestCase().runAll();
	}
	
	public void testAttachingToDeletingEventThrows() {
		if (isEmbedded()) return;
		
		Assert.expect(IllegalArgumentException.class, new CodeBlock() {
			public void run() throws Throwable {
				eventRegistry().deleting().addListener(new EventListener4(){
					public void onEvent(Event4 e, EventArgs args) {
					}
				});
			}
		});			
	}
	
	public void testAttachingToDeleteEventThrows() {
			if (isEmbedded()) return;
				
			Assert.expect(IllegalArgumentException.class, new CodeBlock() {
				public void run() throws Throwable {
					eventRegistry().deleted().addListener(new EventListener4(){
						public void onEvent(Event4 e, EventArgs args) {
						}
					});
				}
			});			
	}
}
