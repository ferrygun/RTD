package rtd;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;


@ServerEndpoint("/rtd")
public class RTD  {
	private static final Set<Session> peers = Collections
			.synchronizedSet(new HashSet<Session>());

	@OnMessage
	public void onMessage(final String message) {
		for (final Session peer : peers) {
			try {
				peer.getBasicRemote().sendText(message);
			} catch (final IOException e) {
				e.printStackTrace();
			}
		}
	}

	@OnOpen
	public void onOpen(final Session peer) {
		peers.add(peer);
	}

	@OnClose
	public void onClose(final Session peer) {
		peers.remove(peer);
	}
}
