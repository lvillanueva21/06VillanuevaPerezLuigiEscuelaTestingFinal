package examples.users;

import com.intuit.karate.junit5.Karate;

class UsersRunner {

    @Karate.Test
    Karate testAll() {
        return Karate.run("store", "users").relativeTo(getClass());
    }

}